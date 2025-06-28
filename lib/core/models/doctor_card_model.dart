import 'package:clinic/core/utils/app_constants.dart';

class DoctorCardModel {
  final int id;
  final String fullName;
  final String specialization;
  final double consultationFee;
  final String imageUrl;
  final double averageRating;

  DoctorCardModel({
    required this.id,
    required this.fullName,
    required this.specialization,
    required this.consultationFee,
    required this.imageUrl,
    required this.averageRating,
  });

  factory DoctorCardModel.fromJson(Map<String, dynamic> json) {
    final user = json[AppConstants.usersTable] ?? {};
    final spec = json[AppConstants.specializationsTable] ?? {};
    final rating = json[AppConstants.doctorAverageRatings];

    return DoctorCardModel(
      id: json[AppConstants.doctorId],
      fullName:
          '${user[AppConstants.userFirstName] ?? ''} ${user[AppConstants.userLastName] ?? ''}',
      specialization:
          spec[AppConstants.specializationSpecialization] ?? 'Unknown',
      consultationFee:
          (json[AppConstants.doctorConsultationFee] as num).toDouble(),
      imageUrl: json[AppConstants.doctorImageUrl] ?? '',
      averageRating:
          rating != null
              ? (rating[AppConstants.doctorRatingValue] as num).toDouble()
              : 0.0,
    );
  }
}
