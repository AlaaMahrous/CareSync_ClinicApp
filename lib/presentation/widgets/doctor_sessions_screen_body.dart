import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/presentation/widgets/doctor_appointments_sessions.dart';
import 'package:flutter/material.dart';

class DoctorSessionsScreenBody extends StatelessWidget {
  const DoctorSessionsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 100, color: ColorsManager.mainAppColor),
            const Expanded(child: DoctorAppointmentsSessions()),
          ],
        ),
      ),
    );
  }
}
