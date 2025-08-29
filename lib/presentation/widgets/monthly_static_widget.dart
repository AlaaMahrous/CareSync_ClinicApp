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
      padding: EdgeInsets.symmetric(vertical: 10),
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
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text('hi'), CustomIndicator()],
          ),
        ],
      ),
    );
  }
}
