import 'package:clinic/core/models/appointment_model.dart';
import 'package:clinic/logic/cubit/doctor_appointments_cubit/doctor_appointments_cubit.dart';
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
      isBooked: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorAppointmentsCubit, DoctorAppointmentsState>(
      builder: (context, state) {
        if (state is DoctorAppointmentsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is DoctorAppointmentsFailure) {
          return Scaffold(body: Center(child: Text('Error: ${state.message}')));
        } else if (state is DoctorAppointmentsLoaded) {
          final appointments = state.appointments;
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return AppointmentCard(appointment: appointment);
            },
          );
        } else {
          return const Scaffold(body: Center(child: Text('Unexpected State')));
        }
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback? onTap;

  const AppointmentCard({super.key, required this.appointment, this.onTap});

  @override
  Widget build(BuildContext context) {
    //final formattedDate = DateFormat.yMMMMd().format(appointment.date);
    //final time = appointment.time;
    return Card(
      color: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(appointment.availableDate.toString()),
    );
  }
}
