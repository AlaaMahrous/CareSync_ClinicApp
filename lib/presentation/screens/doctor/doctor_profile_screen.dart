import 'dart:developer';

import 'package:clinic/core/services/hive/hive_setting_service.dart';
import 'package:clinic/logic/cubit/doctor_profile_cubit/doctor_profile_cubit.dart';
import 'package:clinic/presentation/widgets/doctor_profile_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final settings = SettingsService.getSettings();
  late DoctorProfileCubit doctorProfileCubit;

  @override
  void initState() {
    super.initState();
    doctorProfileCubit =
        DoctorProfileCubit()..getDoctorProfileData(int.parse(settings.userId));
  }

  @override
  void dispose() {
    doctorProfileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: doctorProfileCubit,
      child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
        builder: (context, state) {
          if (state is DoctorProfileLoading) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is DoctorProfileLoadingFaild) {
            log('Something went wrong ${state.errorMessage}');
            return Scaffold(
              body: Center(
                child: Text('Something went wrong\n${state.errorMessage}'),
              ),
            );
          } else if (state is DoctorProfileLoaded) {
            return DoctorProfileScreenBody(
              doctorModel: state.doctorModel,
              editCubit: doctorProfileCubit,
            );
          } else {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: Text('Unexpected state')),
            );
          }
        },
      ),
    );
  }
}
