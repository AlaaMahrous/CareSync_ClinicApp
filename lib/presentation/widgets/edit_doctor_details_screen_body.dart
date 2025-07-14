import 'dart:developer';
import 'dart:io';

import 'package:clinic/core/models/doctor_profile_model.dart';
import 'package:clinic/core/services/supabase/doctor_service.dart';
import 'package:clinic/core/services/supabase/image_service.dart';
import 'package:clinic/logic/cubit/doctor_profile_cubit/doctor_profile_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditDoctorDetailsScreenBody extends StatefulWidget {
  const EditDoctorDetailsScreenBody({
    super.key,
    required this.doctorModel,
    required this.editCubit,
  });
  static final String path = '/EditDoctorDetailsScreenBody';
  final DoctorProfileModel doctorModel;
  final DoctorProfileCubit editCubit;

  @override
  State<EditDoctorDetailsScreenBody> createState() =>
      _EditDoctorDetailsScreenBodyState();
}

class _EditDoctorDetailsScreenBodyState
    extends State<EditDoctorDetailsScreenBody> {
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
  late int id;

  @override
  void initState() {
    super.initState();
    id = widget.doctorModel.id;
    bio = widget.doctorModel.info;
    adress = widget.doctorModel.address;
    number = widget.doctorModel.phone;
    years = widget.doctorModel.experience;
    fee = widget.doctorModel.consultationFee;
    selectedSpecialization = widget.doctorModel.specialization;
    selectedSpecIndex =
        ListsManagar.specializations.indexOf(selectedSpecialization!) + 1;
    imageUrl = widget.doctorModel.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: ColorsManager.mainAppColor,
      ),
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 0),
                child: Column(
                  spacing: 10.h,
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
                    ProfileAvatar(
                      image:
                          imageFile != null
                              ? Image.file(
                                imageFile!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                              : (widget.doctorModel.imageUrl != null
                                  ? Image.network(
                                    widget.doctorModel.imageUrl!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.asset(
                                    'assets/images/profile.jpeg',
                                    height: 100,
                                    width: 100,
                                  )),
                      onTap: () async {
                        imageFile = await ImageService.instance.pickImage();
                        setState(() {});
                      },
                    ),
                    Text(
                      'Update your profile information',
                      style: TextStyleManager.loginInfo,
                    ),

                    InfoTextFeild(
                      maxLength: 200,
                      hintText: 'Write a short bio about yourself',
                      initialValue: widget.doctorModel.info,
                      onSaved: (value) => bio = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this feild is required';
                        }
                        return null;
                      },
                    ),
                    DropFeild(
                      hint: widget.doctorModel.specialization,
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
                      initialValue: widget.doctorModel.address,
                      onSaved: (value) => adress = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this feild is required';
                        }
                        return null;
                      },
                    ),
                    InfoTextFeild(
                      keyboardType: TextInputType.phone,
                      hintText: 'Enter your phone number',
                      initialValue: widget.doctorModel.phone,
                      onSaved: (value) => number = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this feild is required';
                        }
                        return null;
                      },
                    ),
                    InfoTextFeild(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter years of experience',
                      initialValue: widget.doctorModel.experience.toString(),
                      onSaved: (value) => years = double.tryParse(value ?? ''),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this feild is required';
                        }
                        return null;
                      },
                    ),
                    InfoTextFeild(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter consultation fee in dollars',
                      initialValue:
                          widget.doctorModel.consultationFee.toString(),
                      onSaved: (value) => fee = double.tryParse(value ?? ''),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this feild is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomButton(text: 'Update', onTap: updateDoctorData),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateDoctorData() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.always);
      return;
    }

    try {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      await uploadImage();

      await DoctorService.instance.updateDoctorData(
        specialization:
            selectedSpecIndex ??=
                ListsManagar.specializations.indexOf(
                  widget.doctorModel.specialization,
                ) +
                1,
        experienceYear: years!,
        consultationFee: fee!,
        clinicAddress: adress,
        imageUrl: imageUrl ?? widget.doctorModel.imageUrl,
        info: bio,
        phone: number,
      );
      _showMessage('Your profile has been updated successfully.');
      widget.editCubit.getDoctorProfileData(id);
      GoRouter.of(context).pop();
    } catch (e, stack) {
      log('Error in updateDoctorData: $e\n$stack');
      _showMessage('Update failed. Please try again.');
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
