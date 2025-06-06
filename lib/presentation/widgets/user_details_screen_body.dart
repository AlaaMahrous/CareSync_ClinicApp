import 'package:clinic/core/services/supabase/user_service.dart';
import 'package:clinic/core/utils/app_constants.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/image_manager.dart';
import 'package:clinic/core/utils/show_snack_bar.dart';
import 'package:clinic/core/utils/text_style_manager.dart';
import 'package:clinic/presentation/screens/doctor_details_screen.dart';
import 'package:clinic/presentation/screens/patient_home_screen.dart';
import 'package:clinic/presentation/widgets/custom_button.dart';
import 'package:clinic/presentation/widgets/date_picker_feild.dart';
import 'package:clinic/presentation/widgets/drop_feild.dart';
import 'package:clinic/presentation/widgets/info_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailsScreenBody extends StatefulWidget {
  const UserDetailsScreenBody({super.key});
  static final String path = '/UserDetailsScreen';

  @override
  State<UserDetailsScreenBody> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreenBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  TextEditingController birthDateController = TextEditingController();
  bool obscure = true;
  String? firstName;
  String? lastName;
  DateTime? birthDate;
  String? selectedUserType;
  String? selectedUserGender;
  bool _isLoading = false;
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: Column(
                  spacing: 13.h,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                      child: Image.asset(ImageManager.logoPath, height: 50.h),
                    ),
                    Text(
                      'CareSync',
                      style: TextStyleManager.loginTitle.copyWith(
                        fontSize: 22.sp,
                      ),
                    ),
                    Text(
                      'Complete your profile to get started!',
                      style: TextStyleManager.loginInfo,
                    ),
                    SizedBox(height: 5.h),
                    InfoTextFeild(
                      hintText: 'Enter your first name',
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
                    InfoTextFeild(
                      hintText: 'Enter your last name',
                      onSaved: (value) {
                        lastName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    DatePickerField(
                      controller: birthDateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    DropFeild(
                      hint: 'Select Your role',
                      items: const [AppConstants.doctor, AppConstants.patient],
                      selectedItem: selectedUserType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedUserType = newValue;
                        });
                      },
                    ),
                    DropFeild(
                      hint: 'Select your gender',
                      items: const [AppConstants.male, AppConstants.female],
                      selectedItem: selectedUserGender,
                      onChanged: (newValue) {
                        setState(() {
                          selectedUserGender = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 5.h),
                    CustomButton(
                      text:
                          (selectedUserType == AppConstants.doctor)
                              ? 'Start as Doctor'
                              : 'Start Now',
                      onTap: addUser,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (selectedUserType == null || selectedUserGender == null) {
        _showError("Please select both your role and gender.");
        return;
      }
      try {
        setState(() {
          _isLoading = true;
        });
        await UserService.instance.insertUserData(
          firstName: firstName!,
          lastName: lastName!,
          birthDate: DateTime.parse(birthDateController.text).toIso8601String(),
          userGender: selectedUserGender!,
          userRole: selectedUserType!,
        );
        if (selectedUserType == AppConstants.doctor && mounted) {
          GoRouter.of(context).go(DoctorDetailsScreen.path);
        } else {
          if (mounted) {
            GoRouter.of(context).go(PatientHomeScreen.path);
          }
        }
        _showError(
          "Your profile has been successfully completed! Welcome aboard!",
        );
      } on Exception catch (e) {
        _showError("Login failed, an error occurred: ${e.toString()}");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void _showError(String message) {
    showMessage(context, message, ColorsManager.mainAppColor);
  }
}
