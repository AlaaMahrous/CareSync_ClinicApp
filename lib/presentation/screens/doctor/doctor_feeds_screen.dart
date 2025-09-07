import 'package:clinic/core/models/notification_model.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/presentation/widgets/doctor_notify_card.dart';
import 'package:flutter/material.dart';

class DoctorFeedsScreen extends StatelessWidget {
  DoctorFeedsScreen({super.key});

  // Dummy Data
  final List<NotificationModel> notificationList = [
    NotificationModel(
      patientName: 'Alaa Mahrous',
      description: 'Booked a video call session.',
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    NotificationModel(
      patientName: 'Omar Khaled',
      description: 'Transferred \$50 for his session.',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationModel(
      patientName: 'Sara Youssef',
      description: 'Commented: "Very professional!"',
      date: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    NotificationModel(
      patientName: 'Mohamed Ali',
      description: 'Cancelled his upcoming session.',
      date: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    NotificationModel(
      patientName: 'Nourhan Ibrahim',
      description: 'Tried to pay \$30 but payment failed.',
      date: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    NotificationModel(
      patientName: 'Hassan Tarek',
      description: 'Commented: "Great experience, thank you!"',
      date: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    NotificationModel(
      patientName: 'Lina Adel',
      description: 'Booked a new video session.',
      date: DateTime.now().subtract(const Duration(hours: 7)),
    ),
    NotificationModel(
      patientName: 'Lina Adel',
      description: 'Booked a new video session.',
      date: DateTime.now().subtract(const Duration(hours: 7)),
    ),
    NotificationModel(
      patientName: 'Lina Adel',
      description: 'Booked a new video session.',
      date: DateTime.now().subtract(const Duration(hours: 7)),
    ),
    NotificationModel(
      patientName: 'Lina Adel',
      description: 'Booked a new video session.',
      date: DateTime.now().subtract(const Duration(hours: 7)),
    ),
    NotificationModel(
      patientName: 'Lina Adel',
      description: 'Booked a new video session.',
      date: DateTime.now().subtract(const Duration(hours: 7)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Care Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w800,
            fontFamily: 'Cairo',
          ),
        ),
        backgroundColor: ColorsManager.mainAppColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 7, right: 7, top: 8),
        child: ListView.builder(
          itemCount: notificationList.length,
          itemBuilder: (context, index) {
            final feedback = notificationList[index];
            return DoctorNotifyCard(feedback: feedback);
          },
        ),
      ),
    );
  }
}
