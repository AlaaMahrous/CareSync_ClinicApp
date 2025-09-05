import 'package:clinic/core/models/doctor_dashboard_model.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class DashboardInfoCard extends StatelessWidget {
  const DashboardInfoCard({super.key, required this.doctor});

  final DoctorDashboardModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: ColorsManager.mainAppColor,
      child: Row(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(doctor.imageUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.fullName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ratings: ${doctor.ratingCount}    Comments: ${doctor.commentCount}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome back, Wishing you a productive and fulfilling day',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 223, 222, 222),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
