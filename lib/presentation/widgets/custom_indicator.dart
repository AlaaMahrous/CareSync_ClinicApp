import 'package:clinic/core/models/appointment_counts_model.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key, required this.model});
  final AppointmentCountsModel model;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 53,
      lineWidth: 12,
      animation: true,
      percent: (model.bookedCount / (model.availableCount + model.bookedCount))
          .clamp(0.0, 1.0),
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${((model.bookedCount / (model.availableCount + model.bookedCount)) * 100).ceil()}%',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          const Text(
            'Booked',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: ColorsManager.sAppColor,
      backgroundColor: Colors.grey.shade300,
    );
  }
}
