import 'package:clinic/logic/cubit/appointment_counts_cubit/appointment_counts_cubit.dart';
import 'package:clinic/logic/cubit/doctor_appointments_cubit/doctor_appointments_cubit.dart';
import 'package:clinic/logic/cubit/doctor_dashboard_cubit/doctor_dashboard_cubit.dart';
import 'package:clinic/logic/cubit/today_appointment_cubit/today_appointment_cubit.dart';
import 'package:clinic/presentation/doctor_app.dart';
import 'package:clinic/presentation/patient_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicApp extends StatelessWidget {
  const ClinicApp({super.key, required this.isDoctor});
  static final String path = '/ClinicApp';
  final bool isDoctor;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DoctorAppointmentsCubit()),
        BlocProvider(create: (context) => DoctorDashboardCubit()),
        BlocProvider(create: (context) => TodayAppointmentCubit()),
        BlocProvider(create: (context) => AppointmentCountsCubit()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isDoctor ? const DoctorApp() : const PatientApp(),
      ),
    );
  }
}
