import 'package:flutter/material.dart';

class TextStyleManager {
  TextStyleManager._();
  static TextStyle loginTitle = const TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w700,
    fontFamily: 'Cairo',
  );
  static TextStyle loginInfo = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    fontFamily: 'Cairo',
  );
  static TextStyle small = const TextStyle(fontFamily: 'Cairo');
  static const TextStyle loginFeildHint = TextStyle(
    color: Colors.grey,
    fontSize: 15,
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w500,
  );
  static TextStyle loginFeildError = const TextStyle(
    fontFamily: 'Cairo',
    fontWeight: FontWeight.w600,
    fontSize: 11.3,
  );
  static TextStyle onboardingText = const TextStyle(
    fontFamily: 'Cairo',
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
}
