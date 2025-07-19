import 'package:clinic/logic/cubit/doctor_appointments_cubit/doctor_appointments_cubit.dart';
import 'package:clinic/presentation/doctor_app.dart';
import 'package:clinic/presentation/patient_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicApp extends StatelessWidget {
  const ClinicApp({super.key, required this.isDoctor});
  final bool isDoctor;
  static final String path = '/ClinicApp';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => DoctorAppointmentsCubit())],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isDoctor ? const DoctorApp() : const PatientApp(),
      ),
    );
  }
}
