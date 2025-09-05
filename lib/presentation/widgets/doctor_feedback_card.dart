import 'package:clinic/core/models/doctor_feedback_model.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorFeedbackCard extends StatelessWidget {
  final DoctorFeedbackModel feedback;

  const DoctorFeedbackCard({super.key, required this.feedback});

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
            // الاسم والريت
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
                RatingBarIndicator(
                  rating: feedback.rating.toDouble(),
                  itemCount: 5,
                  itemSize: 14,
                  direction: Axis.horizontal,
                  unratedColor: const Color.fromARGB(255, 200, 200, 200),
                  itemBuilder:
                      (context, _) => const Icon(
                        Icons.star,
                        color: ColorsManager.sAppColor,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            // التعليق
            Text(
              feedback.comment,
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
