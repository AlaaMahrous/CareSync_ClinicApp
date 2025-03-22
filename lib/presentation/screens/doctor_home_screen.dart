import 'package:clinic/presentation/widgets/specialization_home_row.dart';
import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});
  static final String path = '/DoctorHomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SpecializationHomeRow());
  }
}
