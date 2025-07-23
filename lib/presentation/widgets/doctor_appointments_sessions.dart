import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/cubit/doctor_appointments_cubit/doctor_appointments_cubit.dart';
import 'package:clinic/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorAppointmentsSessions extends StatefulWidget {
  const DoctorAppointmentsSessions({super.key});

  @override
  State<DoctorAppointmentsSessions> createState() =>
      _DoctorAppointmentsSessionsState();
}

class _DoctorAppointmentsSessionsState
    extends State<DoctorAppointmentsSessions> {
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    context.read<DoctorAppointmentsCubit>().getFilteredAppointments(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorAppointmentsCubit, DoctorAppointmentsState>(
      builder: (context, state) {
        if (state is DoctorAppointmentsLoading) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainAppColor,
              ),
            ),
          );
        } else if (state is DoctorAppointmentsFailure) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('Error: ${state.message}')),
          );
        } else if (state is DoctorAppointmentsLoaded) {
          final appointments = state.appointments;
          if (appointments.isEmpty) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Text(
                  'No appointments available',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return AppointmentCard(appointment: appointment);
            },
          );
        } else {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('Unexpected State')),
          );
        }
      },
    );
  }
}
