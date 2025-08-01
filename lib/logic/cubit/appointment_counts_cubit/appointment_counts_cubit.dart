import 'package:bloc/bloc.dart';
import 'package:clinic/core/models/appointment_counts_model.dart';
import 'package:clinic/core/services/supabase/appointment_service.dart';
import 'package:flutter/material.dart';

part 'appointment_counts_state.dart';

class AppointmentCountsCubit extends Cubit<AppointmentCountsState> {
  AppointmentCountsCubit() : super(AppointmentCountsInitial());

  Future<void> getAppointmentCounts({
    required int year,
    required int month,
    required int doctorId,
  }) async {
    emit(AppointmentCountsLoading());
    try {
      AppointmentCountsModel? counts = await AppointmentService.instance
          .fetchAppointmentCounts(year: year, month: month, doctorId: doctorId);
      emit(AppointmentCountsLoaded(counts));
    } catch (e, trace) {
      emit(AppointmentCountsFailed('$e\n$trace'));
    }
  }
}
