import 'package:bloc/bloc.dart';
import 'package:clinic/core/models/doctor_dashboard_model.dart';
import 'package:clinic/core/services/supabase/doctor_service.dart';
import 'package:flutter/material.dart';

part 'doctor_dashboard_state.dart';

class DoctorDashboardCubit extends Cubit<DoctorDashboardState> {
  DoctorDashboardCubit() : super(DoctorDashboardInitial());

  Future<void> getFilteredAppointments({required int doctorId}) async {
    emit(DoctorDashboardLoading());
    try {
      DoctorDashboardModel doctor = await DoctorService.instance
          .fetchDoctorDashBoard(doctorId);
      emit(DoctorDashboardLoaded(doctor));
    } catch (e, trace) {
      emit(DoctorDashboardLoadedFailed('$e \n $trace'));
    }
  }
}
