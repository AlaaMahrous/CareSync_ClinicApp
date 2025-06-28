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
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = DoctorsListCubit()..fetchDoctors();

    _controller.addListener(() {
      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 200 &&
          _cubit.hasMore &&
          _cubit.state is! DoctorListLoading) {
        _cubit.fetchDoctors();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorsListCubit, DoctorsListState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is DoctorsListInitial ||
            state is DoctorListLoading && _cubit.doctors.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final doctors = _cubit.doctors;

        return ListView.builder(
          controller: _controller,
          itemCount: doctors.length + (_cubit.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= doctors.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final doctor = doctors[index];
            return DoctorCardWidget(doctor: doctor); // ويدجت العرض
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
                doctor.imageUrl,
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
                    doctor.fullName,
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
