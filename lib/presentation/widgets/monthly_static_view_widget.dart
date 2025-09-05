import 'package:clinic/core/models/appointment_counts_model.dart';
import 'package:clinic/logic/cubit/appointment_counts_cubit/appointment_counts_cubit.dart';
import 'package:clinic/presentation/widgets/monthly_static_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonthlyStaticViewWidget extends StatefulWidget {
  const MonthlyStaticViewWidget({super.key});

  @override
  State<MonthlyStaticViewWidget> createState() =>
      _MonthlyStaticViewWidgetState();
}

class _MonthlyStaticViewWidgetState extends State<MonthlyStaticViewWidget> {
  final date = DateTime.now();
  @override
  void initState() {
    context.read<AppointmentCountsCubit>().getAppointmentCounts(
      year: date.year,
      month: date.month,
    );
    super.initState();
  }

  final AppointmentCountsModel model = AppointmentCountsModel(
    availableCount: 200,
    bookedCount: 50,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCountsCubit, AppointmentCountsState>(
      builder: (context, state) {
        if (state is AppointmentCountsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AppointmentCountsLoaded) {
          if (state.counts == null) {
            return const Center(child: Text("No statistics available."));
          }
          return MonthlyStaticCard(model: state.counts!);
        } else if (state is AppointmentCountsFailed) {
          return Center(
            child: Text(
              "Failed to load stats:\n${state.error}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        // Initial state
        return const Center(child: Text("Loading monthly statistics..."));
      },
    );
  }
}
