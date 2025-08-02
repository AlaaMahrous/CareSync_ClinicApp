import 'package:clinic/core/models/appointment_model.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/cubit/today_appointment_cubit/today_appointment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class TodayAppointmentsSessions extends StatefulWidget {
  const TodayAppointmentsSessions({super.key});

  @override
  State<TodayAppointmentsSessions> createState() =>
      _TodayAppointmentsSessionsState();
}

class _TodayAppointmentsSessionsState extends State<TodayAppointmentsSessions> {
  final date = DateTime.now();
  @override
  void initState() {
    context.read<TodayAppointmentCubit>().getTodayAppointments(
      year: date.year,
      month: date.month,
      day: date.day,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayAppointmentCubit, TodayAppointmentState>(
      builder: (context, state) {
        if (state is TodayAppointmentLoading) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainAppColor,
              ),
            ),
          );
        } else if (state is TodayAppointmentFailed) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('Error: ${state.error}')),
          );
        } else if (state is TodayAppointmentLoaded) {
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
            scrollDirection: Axis.horizontal,
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return TodaySessionCard(appointment: appointment);
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

class TodaySessionCard extends StatelessWidget {
  const TodaySessionCard({super.key, required this.appointment});

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat.jm().format(appointment.availableDate);

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time: $formattedTime',
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Duration: ${appointment.duration}min',
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            const Icon(
              HugeIcons.strokeRoundedVideo01,
              color: ColorsManager.sAppColor,
            ),
          ],
        ),
      ),
    );
  }
}
