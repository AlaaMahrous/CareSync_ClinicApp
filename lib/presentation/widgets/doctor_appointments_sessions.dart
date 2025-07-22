import 'package:clinic/core/models/appointment_model.dart';
import 'package:clinic/core/services/supabase/appointment_service.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/cubit/doctor_appointments_cubit/doctor_appointments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

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

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  const AppointmentCard({super.key, required this.appointment});
  @override
  Widget build(BuildContext context) {
    String duration = appointment.duration.toString();
    String date = DateFormat('y - M - d').format(appointment.availableDate);
    String time = DateFormat('hh:mm a').format(appointment.availableDate);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SizedBox(
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleText('Date:'),
                  titleText('Time:'),
                  titleText('Duration:'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCard(text: date),
                  CustomCard(text: time),
                  CustomCard(text: duration),
                ],
              ),
              const SizedBox(width: 33),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Visibility(
                    visible: !appointment.isBooked,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            HugeIcons.strokeRoundedEdit03,
                            color: ColorsManager.sAppColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            AppointmentService.instance.deleteAppointment(
                              appointment.id,
                            );
                            context
                                .read<DoctorAppointmentsCubit>()
                                .getFilteredAppointments(
                                  year: appointment.availableDate.year,
                                  month: appointment.availableDate.month,
                                  day: appointment.availableDate.day,
                                );
                          },
                          child: const Icon(
                            HugeIcons.strokeRoundedDelete01,
                            color: ColorsManager.sAppColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomCard(
                    text: (appointment.isBooked) ? 'Booked' : 'Available',
                    color: appointment.isBooked ? Colors.green : Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text titleText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        fontFamily: 'Cairo',
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.text,
    this.color = ColorsManager.sAppColor,
  });
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      constraints: const BoxConstraints(maxWidth: 110),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
