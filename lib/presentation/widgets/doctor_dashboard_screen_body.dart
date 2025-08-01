import 'package:clinic/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class DoctorDashboardScreenBody extends StatelessWidget {
  const DoctorDashboardScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              color: ColorsManager.mainAppColor,
              child: const Row(),
            ),
          ],
        ),
      ),
    );
  }
}
