part of 'today_appointment_cubit.dart';

@immutable
sealed class TodayAppointmentState {}

final class TodayAppointmentInitial extends TodayAppointmentState {}

class TodayAppointmentLoading extends TodayAppointmentState {}

class TodayAppointmentFailed extends TodayAppointmentState {
  final String error;

  TodayAppointmentFailed(this.error);
}

class TodayAppointmentLoaded extends TodayAppointmentState {
  final List<AppointmentModel> appointments;

  TodayAppointmentLoaded(this.appointments);
}
