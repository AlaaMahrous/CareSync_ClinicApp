import 'package:clinic/presentation/widgets/doctor_sessions_screen_body.dart';
import 'package:flutter/material.dart';

class DoctorSessionsScreen extends StatelessWidget {
  const DoctorSessionsScreen({super.key});
  static final String path = '/DoctorSessionsScreen';

  @override
  Widget build(BuildContext context) {
    return const DoctorSessionsScreenBody();
  }
}
