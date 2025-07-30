import 'package:clinic/core/models/appointment_model.dart';
import 'package:clinic/core/services/supabase/appointment_service.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/cubit/doctor_appointments_cubit/doctor_appointments_cubit.dart';
import 'package:clinic/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

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
                          onTap: () {
                            //AppointmentService.instance.updateAppointment(appointmentId: appointment.doctorId, availableDate: availableDate, duration: duration)
                          },
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
