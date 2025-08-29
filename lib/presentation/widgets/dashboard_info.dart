import 'package:clinic/core/services/hive/hive_setting_service.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/cubit/doctor_dashboard_cubit/doctor_dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardInfo extends StatefulWidget {
  const DashboardInfo({super.key});

  @override
  State<DashboardInfo> createState() => _DashboardInfoState();
}

class _DashboardInfoState extends State<DashboardInfo> {
  final settings = SettingsService.getSettings();

  @override
  void initState() {
    context.read<DoctorDashboardCubit>().getDoctorDashboard(
      doctorId: int.parse(settings.userId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDashboardCubit, DoctorDashboardState>(
      builder: (context, state) {
        if (state is DoctorDashboardLoading) {
          return const Center(
            child: CircularProgressIndicator(color: ColorsManager.mainAppColor),
          );
        } else if (state is DoctorDashboardLoaded) {
          final doctor = state.doctor;

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
        } else if (state is DoctorDashboardLoadedFailed) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return const SizedBox(); // الحالة Initial
        }
      },
    );
  }
}
