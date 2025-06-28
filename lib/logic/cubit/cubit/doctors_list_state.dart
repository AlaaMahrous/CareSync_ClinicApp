part of 'doctors_list_cubit.dart';

@immutable
sealed class DoctorsListState {}

final class DoctorsListInitial extends DoctorsListState {}

class DoctorListLoading extends DoctorsListState {}

class DoctorListLoaded extends DoctorsListState {
  final List<DoctorCardModel> doctors;

  DoctorListLoaded(this.doctors);
}
