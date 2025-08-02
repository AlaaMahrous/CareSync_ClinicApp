import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/presentation/widgets/dashboard_info.dart';
import 'package:clinic/presentation/widgets/gradient_line.dart';
import 'package:clinic/presentation/widgets/today_sessions.dart';
import 'package:flutter/material.dart';

class DoctorDashboardScreenBody extends StatelessWidget {
  const DoctorDashboardScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const DashboardInfo(),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customTitle('Today\'s appointments'),
                    const Row(children: [GradientLine(), TodaySessions()]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text customTitle(String tite) {
    return Text(
      tite,
      style: const TextStyle(
        fontSize: 16,
        fontFamily: 'Cairo',
        color: ColorsManager.mainAppColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
