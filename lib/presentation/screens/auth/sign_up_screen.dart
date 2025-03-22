import 'package:clinic/presentation/widgets/sign_up_screen_form.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static final String path = '/SignUp';

  @override
  Widget build(BuildContext context) {
    return const SignUpScreenForm();
  }
}
