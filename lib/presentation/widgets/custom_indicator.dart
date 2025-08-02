import 'package:clinic/core/models/doctor_dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key, required this.doctor});

  final DoctorDashboardModel doctor;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 40.0,
      lineWidth: 6.0,
      animation: true,
      percent: (doctor.ratingCount / 100).clamp(0.0, 1.0), // من 100
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Rating', style: TextStyle(fontSize: 10)),
          Text(
            '${doctor.ratingCount}%',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.green,
      backgroundColor: Colors.grey.shade300,
    );
  }
}
