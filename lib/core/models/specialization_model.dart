import 'package:clinic/core/utils/app_constants.dart';

class SpecializationModel {
  final int id;
  final String specialization;
  final String image;

  SpecializationModel({
    required this.id,
    required this.specialization,
    required this.image,
  });

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(
      id: json[AppConstants.specializationId],
      specialization: json[AppConstants.specializationSpecialization],
      image: json[AppConstants.specializationImage],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.specializationId: id,
      AppConstants.specializationSpecialization: specialization,
      AppConstants.specializationImage: image,
    };
  }
}
