// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:clinic/core/services/hive/hive_setting_service.dart';
import 'package:clinic/core/services/supabase/doctor_service.dart';
import 'package:clinic/core/services/supabase/image_service.dart';
import 'package:clinic/core/utils/app_constants.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/image_manager.dart';
import 'package:clinic/core/utils/lists_managar.dart';
import 'package:clinic/core/utils/show_snack_bar.dart';
import 'package:clinic/core/utils/text_style_manager.dart';
import 'package:clinic/presentation/doctor_app.dart';
import 'package:clinic/presentation/widgets/custom_button.dart';
import 'package:clinic/presentation/widgets/drop_feild.dart';
import 'package:clinic/presentation/widgets/info_text_feild.dart';
import 'package:clinic/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsScreenBody extends StatefulWidget {
  const DoctorDetailsScreenBody({super.key});

  @override
  State<DoctorDetailsScreenBody> createState() =>
      _DoctorDetailsScreenBodyState();
}

class _DoctorDetailsScreenBodyState extends State<DoctorDetailsScreenBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _isLoading = false;
  File? imageFile;
  String? imageUrl;
  String? bio;
  String? adress;
  String? number;
  double? fee;
  double? years;
  String? selectedSpecialization;
  int? selectedSpecIndex;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: ColorsManager.mainAppColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                child: Column(
                  spacing: 13.h,
                  children: [
                    Row(
                      children: [
                        Image.asset(ImageManager.logoPath, height: 26.h),
                        SizedBox(width: 10.w),
                        Text(
                          'CareSync',
                          style: TextStyleManager.loginTitle.copyWith(
                            fontSize: 19.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 5.w),
                    ProfileAvatar(
                      image:
                          imageFile != null
                              ? Image.file(
                                imageFile!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                              : Image.asset(
                                'assets/images/profile.jpeg',
                                height: 100,
                                width: 100,
                              ),
                      onTap: () async {
                        imageFile = await ImageService.instance.pickImage();
                        setState(() {});
                      },
                    ),
                    Text(
                      'Complete your profile to get started!',
                      style: TextStyleManager.loginInfo,
                    ),
                    SizedBox(height: 0.h),
                    InfoTextFeild(
                      maxLength: 200,
                      hintText: 'Write a short bio about yourself',
                      onSaved: (value) {
                        bio = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Clinic address is required';
                        }
                        return null;
                      },
                    ),
                    DropFeild(
                      hint: 'Select Your specialization',
                      items: ListsManagar.specializations,
                      selectedItem: selectedSpecialization,
                      onChanged: (newValue) {
                        setState(() {
                          selectedSpecialization = newValue;
                          selectedSpecIndex =
                              ListsManagar.specializations.indexOf(newValue!) +
                              1;
                        });
                      },
                    ),
                    InfoTextFeild(
                      hintText: 'Enter your clinic address',
                      onSaved: (value) {
                        adress = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Clinic address is required';
                        }
                        return null;
                      },
                    ),
                    InfoTextFeild(
                      keyboardType: TextInputType.phone,
                      hintText: 'Enter your phone number',
                      onSaved: (value) {
                        number = value.toString();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        }
                        return null;
                      },
                    ),
                    InfoTextFeild(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter years of experience',
                      onSaved: (value) {
                        years = double.tryParse(value ?? '');
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Years of experience is required';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    InfoTextFeild(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter consultation fee in dollars',
                      onSaved: (value) {
                        fee = double.tryParse(value ?? '');
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Years of experience is required';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomButton(text: 'Start', onTap: addDoctorData),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addDoctorData() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.always);
      return;
    }

    if (selectedSpecIndex == null) {
      _showMessage('Please select your specialization.');
      return;
    }

    try {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      await uploadImage();

      if (years == null || fee == null) {
        _showMessage('Invalid input for years of experience or fee.');
        setState(() => _isLoading = false);
        return;
      }

      await DoctorService.instance.insertDoctorData(
        specialization: selectedSpecIndex!,
        experienceYear: years!,
        consultationFee: fee!,
        clinicAddress: adress,
        imageUrl: imageUrl,
        info: bio,
        phone: number,
      );
      Map<String, dynamic>? doctorData =
          await DoctorService.instance.getDoctorData();
      int doctorId = doctorData![AppConstants.doctorId];
      SettingsService.updateSettings(userId: doctorId.toString());

      _showMessage('Your profile has been successfully created.');
      if (mounted) {
        GoRouter.of(context).go(DoctorApp.path);
      }
    } catch (e, stack) {
      log('Error in addDoctorData: $e\n$stack');
      _showMessage('Something went wrong. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> uploadImage() async {
    if (imageFile != null) {
      try {
        imageUrl = await ImageService.instance.uploadAndSaveImage(imageFile!);
      } catch (e, stack) {
        log('Image upload failed: $e\n$stack');
        _showMessage('Image upload failed. Please try again.');
      }
    }
  }

  void _showMessage(String message) {
    showMessage(context, message, ColorsManager.mainAppColor);
  }
}
