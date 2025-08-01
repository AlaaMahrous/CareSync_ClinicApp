part of 'doctor_dashboard_cubit.dart';

@immutable
sealed class DoctorDashboardState {}

final class DoctorDashboardInitial extends DoctorDashboardState {}

class DoctorDashboardLoading extends DoctorDashboardState {}

class DoctorDashboardLoadedFailed extends DoctorDashboardState {
  final String error;

  DoctorDashboardLoadedFailed(this.error);
}

class DoctorDashboardLoaded extends DoctorDashboardState {
  final DoctorDashboardModel doctor;

  DoctorDashboardLoaded(this.doctor);
}
