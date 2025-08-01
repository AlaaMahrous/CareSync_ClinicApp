part of 'appointment_counts_cubit.dart';

@immutable
sealed class AppointmentCountsState {}

final class AppointmentCountsInitial extends AppointmentCountsState {}

class AppointmentCountsLoading extends AppointmentCountsState {}

class AppointmentCountsFailed extends AppointmentCountsState {
  final String error;

  AppointmentCountsFailed(this.error);
}

class AppointmentCountsLoaded extends AppointmentCountsState {
  final AppointmentCountsModel? counts;

  AppointmentCountsLoaded(this.counts);
}
