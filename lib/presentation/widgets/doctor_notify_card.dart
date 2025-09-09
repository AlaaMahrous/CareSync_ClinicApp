import 'package:clinic/core/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorNotifyCard extends StatelessWidget {
  final NotificationModel feedback;

  const DoctorNotifyCard({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  feedback.patientName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Cairo',
                    color: Color.fromARGB(255, 83, 83, 83),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy  hh:mm a').format(feedback.date),
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Cairo',
                    color: Color.fromARGB(255, 163, 163, 163),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),

            Text(
              feedback.description,
              style: const TextStyle(
                fontSize: 12.5,
                color: Colors.grey,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
