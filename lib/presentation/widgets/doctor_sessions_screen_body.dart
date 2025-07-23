import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/presentation/widgets/doctor_appointments_sessions.dart';
import 'package:clinic/presentation/widgets/filter_form.dart';
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
            Container(
              height: 185,
              color: ColorsManager.mainAppColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const FilterForm(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset('assets/images/dss.png', height: 170),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Expanded(child: DoctorAppointmentsSessions()),
          ],
        ),
      ),
    );
  }
}
