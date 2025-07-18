import 'package:clinic/core/utils/app_constants.dart';

class AppointmentModel {
  final int id;
  final int? patientId;
  final int doctorId;
  final DateTime availableDate;
  final int duration;
  final bool isBooked;
  final DateTime createdAt;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.availableDate,
    required this.duration,
    required this.isBooked,
    required this.createdAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json[AppConstants.appointmentId],
      patientId: json[AppConstants.appointmentPatientId],
      doctorId: json[AppConstants.appointmentDoctorId],
      availableDate: DateTime.parse(
        json[AppConstants.appointmentAvailableDate],
      ),
      duration: json[AppConstants.appointmentDuration],
      isBooked: json[AppConstants.appointmentIsBooked],
      createdAt: DateTime.parse(json[AppConstants.appointmentCreatedAt]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.appointmentId: id,
      AppConstants.appointmentPatientId: patientId,
      AppConstants.appointmentDoctorId: doctorId,
      AppConstants.appointmentAvailableDate: availableDate.toIso8601String(),
      AppConstants.appointmentDuration: duration,
      AppConstants.appointmentIsBooked: isBooked,
      AppConstants.appointmentCreatedAt: createdAt.toIso8601String(),
    };
  }
}
