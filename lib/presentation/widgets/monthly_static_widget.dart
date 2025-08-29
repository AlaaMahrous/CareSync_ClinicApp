import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/cubit/appointment_counts_cubit/appointment_counts_cubit.dart';
import 'package:clinic/presentation/widgets/custom_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonthlyStaticWidget extends StatefulWidget {
  const MonthlyStaticWidget({super.key});

  @override
  State<MonthlyStaticWidget> createState() => _MonthlyStaticWidgetState();
}

class _MonthlyStaticWidgetState extends State<MonthlyStaticWidget> {
  final date = DateTime.now();
  @override
  void initState() {
    context.read<AppointmentCountsCubit>().getAppointmentCounts(
      year: date.year,
      month: date.month,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Monthly statistics',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  color: ColorsManager.mainAppColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New availability you created this month: 255',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  Text(
                    'Unbooked and available to schedule: 200',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  Text(
                    'Reserved by patients: 55',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              CustomIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
