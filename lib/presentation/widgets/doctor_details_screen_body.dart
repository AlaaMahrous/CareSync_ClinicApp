import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/image_manager.dart';
import 'package:clinic/core/utils/lists_managar.dart';
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
  String? firstName;
  String? selectedSpecialization;
  int? selectedSpecIndex;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: false,
      progressIndicator: const CircularProgressIndicator(
        color: ColorsManager.mainAppColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                child: Column(
                  spacing: 13.h,
                  children: [
                    Row(
                      children: [
                        Image.asset(ImageManager.logoPath, height: 25.h),
                        SizedBox(width: 5.w),
                        Text(
                          'CareSync',
                          style: TextStyleManager.loginTitle.copyWith(
                            fontSize: 19.sp,
                          ),
                        ),
                      ],
                    ),
                    const ProfileAvatar(),
                    SizedBox(height: 5.h),
                    Text(
                      'Complete your profile to get started!',
                      style: TextStyleManager.loginInfo,
                    ),
                    SizedBox(height: 5.h),
                    InfoTextFeild(
                      hintText: 'Enter your clinic address',
                      onSaved: (value) {
                        firstName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    DropFeild(
                      hint: 'Select Your role',
                      items: ListsManagar.specializations,
                      selectedItem: selectedSpecialization,
                      onChanged: (newValue) {
                        setState(() {
                          selectedSpecialization = newValue;
                          selectedSpecIndex = ListsManagar.specializations
                              .indexOf(newValue!);
                          print('Selected Index: ${selectedSpecIndex! + 1}');
                        });
                      },
                    ),
                    CustomButton(text: 'Start', onTap: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
