import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyleManager {
  TextStyleManager._();
  static TextStyle loginTitle = TextStyle(
    fontSize: 35.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'Cairo',
  );
  static TextStyle loginInfo = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w800,
    fontFamily: 'Cairo',
  );
  static TextStyle small = const TextStyle(fontFamily: 'Cairo');
  static TextStyle loginFeildHint = TextStyle(
    color: Colors.grey,
    fontSize: 15.sp,
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w500,
  );
  static TextStyle loginFeildError = TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w600,
    fontSize: 11.3.sp,
  );
  static TextStyle onboardingText = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
  );
}
