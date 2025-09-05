import 'package:clinic/core/models/appointment_counts_model.dart';
import 'package:clinic/presentation/widgets/custom_indicator.dart';
import 'package:flutter/material.dart';

class MonthlyStaticCard extends StatelessWidget {
  const MonthlyStaticCard({super.key, required this.model});
  final AppointmentCountsModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New availability you created this month: ${model.availableCount + model.bookedCount}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  'Unbooked and available to schedule: ${model.availableCount}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  'Reserved by patients: ${model.bookedCount}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
            CustomIndicator(model: model),
          ],
        ),
      ],
    );
  }
}
