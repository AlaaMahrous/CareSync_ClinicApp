import 'package:clinic/core/utils/app_constants.dart';

class DoctorAvailableAppointmentModel {
  final int id;
  final int doctorId;
  final DateTime availableDate;
  final String availableTime;
  final bool isBooked;
  final int duration;

  DoctorAvailableAppointmentModel({
    required this.id,
    required this.doctorId,
    required this.availableDate,
    required this.availableTime,
    required this.isBooked,
    required this.duration,
  });

  factory DoctorAvailableAppointmentModel.fromJson(Map<String, dynamic> json) {
    return DoctorAvailableAppointmentModel(
      id: json[AppConstants.doctorAvailableAppointmentId],
      doctorId: json[AppConstants.doctorAvailableAppointmentDoctorId],
      availableDate: DateTime.parse(
        json[AppConstants.doctorAvailableAppointmentDate],
      ),
      availableTime: json[AppConstants.doctorAvailableAppointmentTime],
      isBooked: json[AppConstants.doctorAvailableAppointmentIsBooked],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.doctorAvailableAppointmentId: id,
      AppConstants.doctorAvailableAppointmentDoctorId: doctorId,
      AppConstants.doctorAvailableAppointmentDate:
          availableDate.toIso8601String().split('T').first,
      AppConstants.doctorAvailableAppointmentTime: availableTime,
      AppConstants.doctorAvailableAppointmentIsBooked: isBooked,
      'duration': duration,
    };
  }
}
