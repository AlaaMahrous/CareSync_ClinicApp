import 'package:clinic/core/models/doctor_card_model.dart';
import 'package:clinic/logic/cubit/cubit/doctors_list_cubit.dart';
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

class DoctorCardWidget extends StatelessWidget {
  final DoctorCardModel doctor;

  const DoctorCardWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // صورة الطبيب
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                doctor.imageUrl ??
                    'https://i.pinimg.com/736x/3c/ae/07/3cae079ca0b9e55ec6bfc1b358c9b1e2.jpg',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.person, size: 70),
              ),
            ),
            const SizedBox(width: 12),
            // بيانات الطبيب
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialization,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        doctor.averageRating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Text(
                        '${doctor.consultationFee.toStringAsFixed(0)} EGP',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
