// ignore_for_file: must_be_immutable

import 'package:clinic/core/utils/image_manager.dart';
import 'package:clinic/core/utils/text_style_manager.dart';
import 'package:clinic/presentation/screens/auth/sign_up_screen.dart';
import 'package:clinic/presentation/widgets/custom_button.dart';
import 'package:clinic/presentation/widgets/custom_text_button.dart';
import 'package:clinic/presentation/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenBody extends StatelessWidget {
  LoginScreenBody({
    super.key,
    required this.emailOnSaved,
    required this.emailValidator,
    required this.passwordOnSaved,
    required this.passwordValidator,
    required this.suffixPasswordIcon,
    this.obscurePasswordText = false,
    required this.onForgetPasswordTap,
    required this.onLoginTap,
  });
  final void Function(String?) emailOnSaved;
  final String? Function(String?) emailValidator;
  final void Function(String?) passwordOnSaved;
  final String? Function(String?) passwordValidator;
  final Widget suffixPasswordIcon;
  bool obscurePasswordText;
  final void Function() onForgetPasswordTap;
  final void Function() onLoginTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              spacing: 13.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.h, bottom: 10.h),
                  child: Image.asset(ImageManager.logoPath, height: 90.h),
                ),
                Text('CareSync', style: TextStyleManager.loginTitle),
                Text(
                  'Login to manage your medical appointments',
                  style: TextStyleManager.loginInfo,
                ),
                SizedBox(height: 18.h),
                CustomTextFeild(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: 'Your email address',
                  onSaved: emailOnSaved,
                  validator: emailValidator,
                ),
                CustomTextFeild(
                  obscureText: obscurePasswordText,
                  suffixIcon: suffixPasswordIcon,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  hintText: 'Enter your password',
                  onSaved: passwordOnSaved,
                  validator: passwordValidator,
                ),
                const SizedBox(height: 0),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    text: 'Forget your password?',
                    onTap: onForgetPasswordTap,
                  ),
                ),
                const SizedBox(height: 0),
                CustomButton(text: 'Login', onTap: onLoginTap),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Need to create an account?',
                      style: TextStyleManager.loginInfo.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    CustomTextButton(
                      text: ' SignUp',
                      onTap: () {
                        GoRouter.of(context).push(SignUpScreen.path);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
