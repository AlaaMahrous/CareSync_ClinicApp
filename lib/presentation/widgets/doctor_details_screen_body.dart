// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:clinic/core/services/supabase/image_service.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/image_manager.dart';
import 'package:clinic/core/utils/lists_managar.dart';
import 'package:clinic/core/utils/show_snack_bar.dart';
import 'package:clinic/core/utils/text_style_manager.dart';
import 'package:clinic/presentation/widgets/custom_button.dart';
import 'package:clinic/presentation/widgets/drop_feild.dart';
import 'package:clinic/presentation/widgets/info_text_feild.dart';
import 'package:clinic/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
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
  String? firstName;
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
                        await uploadImage(context);
                      },
                    ),
                    Text(
                      'Complete your profile to get started!',
                      style: TextStyleManager.loginInfo,
                    ),
                    SizedBox(height: 0.h),
                    InfoTextFeild(
                      hintText: 'Write a short bio about yourself',
                      onSaved: (value) {
                        firstName = value;
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
                          selectedSpecIndex = ListsManagar.specializations
                              .indexOf(newValue!);
                          log('Selected Index: ${selectedSpecIndex! + 1}');
                        });
                      },
                    ),
                    InfoTextFeild(
                      hintText: 'Enter your clinic address',
                      onSaved: (value) {
                        firstName = value;
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
                        firstName = value;
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
                        firstName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Years of experience is required';
                        }
                        return null;
                      },
                    ),
                    InfoTextFeild(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter consultation fee',
                      onSaved: (value) {
                        firstName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Consultation fee is required';
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

  Future<void> uploadImage(BuildContext context) async {
    if (imageFile != null) {
      try {
        imageUrl = await ImageService.instance.uploadAndSaveImage(imageFile!);
        showMessage(
          context,
          'The image uploaded successfully',
          ColorsManager.mainAppColor,
        );
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  void addDoctorData() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.always);
      return;
    }

    _formKey.currentState!.save();
    setState(() => _isLoading = true);
  }
}
