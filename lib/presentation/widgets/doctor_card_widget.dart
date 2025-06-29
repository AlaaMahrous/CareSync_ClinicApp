import 'package:clinic/core/models/doctor_card_model.dart';
import 'package:flutter/material.dart';

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
