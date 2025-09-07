import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/presentation/widgets/dashboard_info.dart';
import 'package:clinic/presentation/widgets/doctor_feedback_list_view.dart';
import 'package:clinic/presentation/widgets/gradient_line.dart';
import 'package:clinic/presentation/widgets/monthly_static_view_widget.dart';
import 'package:clinic/presentation/widgets/today_appointments_sessions.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customTitle('Today\'s appointments'),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 75,
                      child: Row(
                        children: [
                          GradientLine(),
                          Expanded(child: TodayAppointmentsSessions()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    customTitle('Monthly statistics'),
                    const SizedBox(
                      height: 116,
                      child: MonthlyStaticViewWidget(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [customTitle('Patients comments')],
                    ),
                    const SizedBox(
                      height: 280,
                      child: DoctorFeedbackListView(),
                    ),
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
