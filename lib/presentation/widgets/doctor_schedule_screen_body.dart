import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/presentation/widgets/custom_button.dart';
import 'package:clinic/presentation/widgets/date_picker_feild.dart';
import 'package:clinic/presentation/widgets/info_text_feild.dart';
import 'package:clinic/presentation/widgets/time_picker_feild.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DoctorScheduleScreenBody extends StatefulWidget {
  const DoctorScheduleScreenBody({super.key});

  @override
  State<DoctorScheduleScreenBody> createState() =>
      _DoctorScheduleScreenBodyState();
}

class _DoctorScheduleScreenBodyState extends State<DoctorScheduleScreenBody> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

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
        inAsyncCall: false,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
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
                          lastDate: DateTime(2030),
                          hintText: 'Select Your Session Date',
                          controller: _dateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Your birth Date is required';
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
                              return 'Please select a time';
                            }
                            return null;
                          },
                          hintText: 'Select consultation time',
                        ),
                        const SizedBox(height: 10),
                        title('Set your Session Duration'),
                        InfoTextFeild(
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
                            onTap: () {},
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
}
