import 'package:clinic/presentation/widgets/login_screen_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static final String path = '/LoginScreen';

  @override
  Widget build(BuildContext context) {
    return const LoginScreenForm();
  }
}
