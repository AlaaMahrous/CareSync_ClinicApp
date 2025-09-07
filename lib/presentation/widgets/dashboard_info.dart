import 'package:clinic/core/services/hive/hive_setting_service.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/cubit/doctor_dashboard_cubit/doctor_dashboard_cubit.dart';
import 'package:clinic/presentation/widgets/dashboard_info_card.dart';
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

          return DashboardInfoCard(doctor: doctor);
        } else if (state is DoctorDashboardLoadedFailed) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
