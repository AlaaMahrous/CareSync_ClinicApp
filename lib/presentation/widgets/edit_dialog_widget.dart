import 'dart:developer';

import 'package:clinic/core/models/appointment_model.dart';
import 'package:clinic/core/services/supabase/appointment_service.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/show_snack_bar.dart';
import 'package:clinic/logic/cubit/doctor_appointments_cubit/doctor_appointments_cubit.dart';
import 'package:clinic/presentation/widgets/custom_content_dialog.dart';
import 'package:clinic/presentation/widgets/info_text_feild.dart';
import 'package:clinic/presentation/widgets/time_picker_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditDialogWidget extends StatefulWidget {
  const EditDialogWidget({
    super.key,
    required this.appointment,
    required this.context1,
  });
  final AppointmentModel appointment;
  final BuildContext context1;

  @override
  State<EditDialogWidget> createState() => _EditDialogWidgetState();
}

class _EditDialogWidgetState extends State<EditDialogWidget> {
  late TextEditingController _timeController;
  late TextEditingController _durationController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late DateTime? selectedDateTime;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _timeController = TextEditingController(
      text: DateFormat('hh:mm a').format(widget.appointment.availableDate),
    );
    _durationController = TextEditingController(
      text: widget.appointment.duration.toString(),
    );
  }

  @override
  void dispose() {
    _timeController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: ColorsManager.mainAppColor,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: AlertDialog(
          title: const Text(
            'Confirm Deletion',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorsManager.mainAppColor,
              fontFamily: 'Cairo',
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please confirm if you want to save the changes to the appointment time and duration',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.mainAppColor,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 10),
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: editSession,
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 16,
                  color: ColorsManager.mainAppColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.mainAppColor,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          elevation: 8,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  void editSession() async {
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
      ).parse(widget.appointment.availableDate.toString());

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
        await AppointmentService.instance.updateAppointment(
          appointmentId: widget.appointment.id,
          availableDate: selectedDateTime!,
          duration: int.parse(_durationController.text),
        );

        _showError('Session updated successfully');

        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        if (mounted) {
          Navigator.of(context).pop();
          showOverlapDialog(context, customMessage: 'Appointments Overlap');
        }
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

  void updateUi(BuildContext context) async {
    context.read<DoctorAppointmentsCubit>().getFilteredAppointments(
      year: widget.appointment.availableDate.year,
      month: widget.appointment.availableDate.month,
      day: widget.appointment.availableDate.day,
      isBooked: null,
    );

    /* context.read<TodayAppointmentCubit>().getTodayAppointments(
      year: DateTime.now().year,
      month: DateTime.now().month,
      day: DateTime.now().day,
    );*/
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
