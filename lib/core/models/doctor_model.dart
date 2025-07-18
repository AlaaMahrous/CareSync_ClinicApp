import 'package:clinic/core/utils/app_constants.dart';

class DoctorModel {
  final int id;
  final int userId;
  final int specialization;
  final double experience;
  final String? clinicAddress;
  final double consultationFee;
  final String? imageUrl;
  final String? info;
  final String? phoneNumber;

  DoctorModel({
    required this.id,
    required this.userId,
    required this.specialization,
    required this.experience,
    this.clinicAddress,
    required this.consultationFee,
    this.imageUrl,
    this.info,
    this.phoneNumber,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json[AppConstants.doctorId],
      userId: json[AppConstants.doctorUserId],
      specialization: json[AppConstants.doctorSpecializationId],
      experience: (json[AppConstants.doctorExperience] as num).toDouble(),
      clinicAddress: json[AppConstants.doctorClinicAddress],
      consultationFee:
          (json[AppConstants.doctorConsultationFee] as num).toDouble(),
      imageUrl: json[AppConstants.doctorImageUrl],
      info: json[AppConstants.doctorInfo],
      phoneNumber: json[AppConstants.doctorPhoneNumber],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.doctorId: id,
      AppConstants.doctorUserId: userId,
      AppConstants.doctorSpecializationId: specialization,
      AppConstants.doctorExperience: experience,
      AppConstants.doctorClinicAddress: clinicAddress,
      AppConstants.doctorConsultationFee: consultationFee,
      AppConstants.doctorImageUrl: imageUrl,
      AppConstants.doctorInfo: info,
      AppConstants.doctorPhoneNumber: phoneNumber,
    };
  }
}
