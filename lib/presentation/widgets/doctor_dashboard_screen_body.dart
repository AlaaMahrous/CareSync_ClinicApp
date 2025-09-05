import 'package:clinic/core/models/doctor_feedback_model.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/presentation/widgets/dashboard_info.dart';
import 'package:clinic/presentation/widgets/doctor_feedback_card.dart';
import 'package:clinic/presentation/widgets/gradient_line.dart';
import 'package:clinic/presentation/widgets/monthly_static_widget.dart';
import 'package:clinic/presentation/widgets/today_appointments_sessions.dart';
import 'package:flutter/material.dart';

class DoctorDashboardScreenBody extends StatelessWidget {
  DoctorDashboardScreenBody({super.key});

  // Dummy Data باستخدام DoctorFeedbackModel
  final List<DoctorFeedbackModel> feedbackList = [
    DoctorFeedbackModel(
      patientName: 'Alaa Mahrous',
      comment:
          'The video call quality was good, and the doctor was very patient while answering all my questions.',
      rating: 4,
    ),
    DoctorFeedbackModel(
      patientName: 'Omar Khaled',
      comment:
          'Dr. Ahmed explained everything clearly and made me feel very comfortable during the online session.',
      rating: 5,
    ),
    DoctorFeedbackModel(
      patientName: 'Sara Youssef',
      comment:
          'The consultation was smooth and professional. Very convenient to do it online.',
      rating: 4,
    ),
    DoctorFeedbackModel(
      patientName: 'Mohamed Ali',
      comment:
          'Great experience! He listened carefully and gave me the right treatment plan.',
      rating: 5,
    ),
    DoctorFeedbackModel(
      patientName: 'Nourhan Ibrahim',
      comment:
          'The doctor was kind and patient, but the session started a bit late.',
      rating: 3,
    ),
    DoctorFeedbackModel(
      patientName: 'Hassan Tarek',
      comment:
          'Even though it was online, I felt real care and support. Highly recommended.',
      rating: 4,
    ),
    DoctorFeedbackModel(
      patientName: 'Lina Adel',
      comment:
          'Very professional and respectful, I will definitely book another online session.',
      rating: 5,
    ),
  ];

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
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customTitle('Today\'s appointments'),
                    const SizedBox(
                      height: 75,
                      child: Row(
                        children: [
                          GradientLine(),
                          Expanded(child: TodayAppointmentsSessions()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 158, child: MonthlyStaticWidget()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [customTitle('Patients comments')],
                    ),
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        itemCount: feedbackList.length,
                        itemBuilder: (context, index) {
                          final feedback = feedbackList[index];
                          return DoctorFeedbackCard(feedback: feedback);
                        },
                      ),
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
