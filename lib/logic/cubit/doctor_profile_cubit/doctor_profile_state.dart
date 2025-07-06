part of 'doctor_profile_cubit.dart';

@immutable
sealed class DoctorProfileState {}

final class DoctorProfileInitial extends DoctorProfileState {}

final class DoctorProfileLoading extends DoctorProfileState {}

final class DoctorProfileLoadingFaild extends DoctorProfileState {
  final String errorMessage;

  DoctorProfileLoadingFaild({required this.errorMessage});
}

final class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorProfileModel doctorModel;

  DoctorProfileLoaded({required this.doctorModel});
}
