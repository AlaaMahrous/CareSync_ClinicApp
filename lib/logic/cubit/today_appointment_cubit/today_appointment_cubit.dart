import 'package:bloc/bloc.dart';
import 'package:clinic/core/models/appointment_counts_model.dart';
import 'package:clinic/core/services/supabase/appointment_service.dart';
import 'package:flutter/material.dart';

part 'today_appointment_state.dart';

class TodayAppointmentCubit extends Cubit<TodayAppointmentState> {
  TodayAppointmentCubit() : super(TodayAppointmentInitial());

  Future<void> getTodayAppointmentsCount({
    required int year,
    required int month,
    required int doctorId,
  }) async {
    emit(TodayAppointmentLoading());

    try {
      AppointmentCountsModel static = await AppointmentService.instance
          .fetchAppointmentCounts(doctorId: doctorId, year: year, month: month);
      emit(TodayAppointmentLoaded(static));
    } catch (e, trace) {
      emit(TodayAppointmentFailed('$e\n$trace'));
    }
  }
}
