import 'package:clinic/core/utils/app_constants.dart';

class AppointmentModel {
  final int id;
  final int patientId;
  final int doctorId;
  final int slotId;
  final String status;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.slotId,
    required this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json[AppConstants.appointmentId],
      patientId: json[AppConstants.appointmentPatientId],
      doctorId: json[AppConstants.appointmentDoctorId],
      slotId: json[AppConstants.appointmentSlotId],
      status: json[AppConstants.appointmentStatus],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.appointmentId: id,
      AppConstants.appointmentPatientId: patientId,
      AppConstants.appointmentDoctorId: doctorId,
      AppConstants.appointmentSlotId: slotId,
      AppConstants.appointmentStatus: status,
    };
  }
}
