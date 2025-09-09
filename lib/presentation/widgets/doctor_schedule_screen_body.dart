import 'dart:developer';

import 'package:clinic/core/models/appointment_model.dart';
import 'package:clinic/core/services/supabase/appointment_service.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/show_snack_bar.dart';
import 'package:clinic/logic/cubit/doctor_appointments_cubit/doctor_appointments_cubit.dart';
import 'package:clinic/logic/cubit/today_appointment_cubit/today_appointment_cubit.dart';
import 'package:clinic/presentation/widgets/custom_button.dart';
import 'package:clinic/presentation/widgets/date_picker_feild.dart';
import 'package:clinic/presentation/widgets/info_text_feild.dart';
import 'package:clinic/presentation/widgets/custom_content_dialog.dart';
import 'package:clinic/presentation/widgets/time_picker_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DoctorScheduleScreenBody extends StatefulWidget {
  const DoctorScheduleScreenBody({super.key});

  @override
  State<DoctorScheduleScreenBody> createState() =>
      _DoctorScheduleScreenBodyState();
}

class _DoctorScheduleScreenBodyState extends State<DoctorScheduleScreenBody> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController(); //
  final TextEditingController _durationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late DateTime? selectedDateTime;
  bool _isLoading = false;

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        progressIndicator: const CircularProgressIndicator(
          color: ColorsManager.mainAppColor,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 170),
                        title('Choose a Date for Your Session'),
                        DatePickerField(
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2200),
                          hintText: 'Select Your Session Date',
                          controller: _dateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Session Date is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        title('Choose a Time for Your Session'),
                        TimePickerField(
                          controller: _timeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Session time is required';
                            }
                            return null;
                          },
                          hintText: 'Select consultation time',
                        ),
                        const SizedBox(height: 10),
                        title('Set your Session Duration'),
                        InfoTextFeild(
                          controller: _durationController,
                          keyboardType: TextInputType.number,
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'min',
                              style: TextStyle(
                                color: ColorsManager.mainAppColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          vertical: 15,
                          hintText: 'Enter your session duration in minutes',
                          onSaved: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Session duration is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                            onTap: addSession,
                            text: 'Add Session',
                            width: 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    color: ColorsManager.mainAppColor,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Manage Your Sessions Time',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        Text(
                          'Easily add available session times for your\npatients',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -15,
                    top: 10,
                    child: Image.asset('assets/images/ds.png', height: 140),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addSession() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    setState(() {
      _isLoading = true;
      _autovalidateMode = AutovalidateMode.disabled;
    });
    try {
      final DateTime date = DateFormat(
        'yyyy-MM-dd',
      ).parse(_dateController.text);

      final DateTime parsedTime = DateFormat(
        'hh:mm a',
      ).parse(_timeController.text);

      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        parsedTime.hour,
        parsedTime.minute,
      );
      final List<AppointmentModel> appointments = await AppointmentService
          .instance
          .getFilteredAppointments(
            year: date.year,
            month: date.month,
            day: date.day,
            isBooked: null,
          );
      bool isOverLapping = AppointmentService.instance.isOverlapping(
        existingAppointments: appointments,
        newStart: selectedDateTime!,
        newDurationMinutes: int.parse(_durationController.text),
      );

      if (!isOverLapping) {
        await AppointmentService.instance.addAppointment(
          availableDate: selectedDateTime!,
          duration: int.parse(_durationController.text),
        );
        _showError('Session added successfully');
        _dateController.clear();
        _timeController.clear();
        _durationController.clear();
        if (mounted) {
          context.read<DoctorAppointmentsCubit>().getFilteredAppointments(
            year: DateTime.now().year,
            month: DateTime.now().month,
            day: DateTime.now().day,
            isBooked: null,
          );
          context.read<TodayAppointmentCubit>().getTodayAppointments(
            year: DateTime.now().year,
            month: DateTime.now().month,
            day: DateTime.now().day,
          );
        }
      } else {
        await Future.delayed(const Duration(seconds: 1));
        showOverlapDialog(context, customMessage: 'Appointments Overlap');
        _dateController.clear();
        _timeController.clear();
        _durationController.clear();
      }
    } catch (e) {
      _showError('Something went wrong. Please try again.');
      log('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Text title(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: ColorsManager.mainAppColor,
        fontSize: 14.5,
        fontWeight: FontWeight.w900,
        fontFamily: 'Cairo',
      ),
    );
  }

  void _showError(String message) {
    showMessage(context, message, ColorsManager.mainAppColor);
  }
}

void showOverlapDialog(BuildContext context, {String? customMessage}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomContentDialog(
        customTitle: customMessage!,
        content: const Text(
          'The new appointment overlaps with a previously scheduled appointment. Please choose a different time.',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    },
  );
}
