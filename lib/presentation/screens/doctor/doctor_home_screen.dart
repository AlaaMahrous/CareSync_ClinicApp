import 'package:clinic/presentation/widgets/patient_home_screen_body.dart';
import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});
  static final String path = '/DoctorHomeScreen';

  @override
  Widget build(BuildContext context) {
    return const PatientHomeScreenBody();
  }
}
