import 'package:clinic/presentation/widgets/doctor_dashboard_screen_body.dart';
import 'package:flutter/material.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});
  static final String path = '/DoctorDashboardScreen';

  @override
  Widget build(BuildContext context) {
    return DoctorDashboardScreenBody();
  }
}
