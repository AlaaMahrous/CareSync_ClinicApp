import 'package:clinic/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60,
      lineWidth: 13,
      animation: true,
      percent: (55 / 100).clamp(0.0, 1.0),
      center: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '50%',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          Text('Booked', style: TextStyle(fontSize: 10)),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: ColorsManager.sAppColor,
      backgroundColor: Colors.grey.shade300,
    );
  }
}
