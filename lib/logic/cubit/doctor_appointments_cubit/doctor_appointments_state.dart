part of 'doctor_appointments_cubit.dart';

@immutable
sealed class DoctorAppointmentsState {}

final class DoctorAppointmentsInitial extends DoctorAppointmentsState {}

final class DoctorAppointmentsLoading extends DoctorAppointmentsState {}

final class DoctorAppointmentsLoaded extends DoctorAppointmentsState {
  final List<AppointmentModel> appointments;

  DoctorAppointmentsLoaded(this.appointments);
}

final class DoctorAppointmentsFailure extends DoctorAppointmentsState {
  final String message;

  DoctorAppointmentsFailure(this.message);
}
