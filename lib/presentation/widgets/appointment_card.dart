import 'package:clinic/core/models/appointment_model.dart';
import 'package:clinic/core/services/supabase/appointment_service.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/cubit/doctor_appointments_cubit/doctor_appointments_cubit.dart';
import 'package:clinic/presentation/widgets/custom_card.dart';
import 'package:clinic/presentation/widgets/edit_dialog_widget.dart';
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
                            showEditMessage(context, appointment);
                          },
                          child: const Icon(
                            HugeIcons.strokeRoundedEdit03,
                            color: ColorsManager.sAppColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            showDeleteMessage(context, () {
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
                            });
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

void showDeleteMessage(BuildContext context, void Function() onPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Confirm Deletion',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsManager.mainAppColor,
            fontFamily: 'Cairo',
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this appointment?',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontFamily: 'Cairo',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onPressed.call();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorsManager.mainAppColor,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        elevation: 8,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      );
    },
  );
}

void showEditMessage(BuildContext context, AppointmentModel appointment) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditDialogWidget(appointment: appointment, context1: context);
    },
  );
}
