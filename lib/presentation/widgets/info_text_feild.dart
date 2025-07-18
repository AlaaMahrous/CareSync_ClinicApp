// ignore_for_file: must_be_immutable

import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/text_style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoTextFeild extends StatelessWidget {
  InfoTextFeild({
    super.key,
    this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onSaved,
    required this.validator,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.initialValue,
    this.vertical = 0,
  });
  final String? initialValue;
  final Widget? prefixIcon;
  final String hintText;
  bool obscureText;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLength: maxLength,
      controller: controller,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: 15.w,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyleManager.loginFeildHint,
        errorStyle: TextStyleManager.loginFeildError,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: ColorsManager.mainAppColor,
            width: 1.7.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: ColorsManager.mainAppColor, width: 1.w),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
