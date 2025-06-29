import 'package:clinic/core/models/doctor_card_model.dart';
import 'package:clinic/logic/cubit/cubit/doctors_list_cubit.dart';
import 'package:clinic/presentation/widgets/doctor_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListView extends StatefulWidget {
  const DoctorsListView({super.key});

  @override
  State<DoctorsListView> createState() => _DoctorListViewState();
}

class _DoctorListViewState extends State<DoctorsListView> {
  late final DoctorsListCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = DoctorsListCubit()..fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorsListCubit, DoctorsListState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is DoctorsListInitial || state is DoctorListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DoctorListLoadedFaild) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Failed to load doctors.\n${state.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _cubit.fetchDoctors,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is DoctorListLoaded) {
          final doctors = state.doctors;
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return DoctorCardWidget(doctor: doctor);
            },
          );
        }

        // fallback (shouldn't happen, but good practice)
        return const Center(child: Text('Unexpected state'));
      },
    );
  }

  @override
  void dispose() {
    _cubit.close(); // مهم جدًا عشان نغلق الـ Cubit
    super.dispose();
  }
}
