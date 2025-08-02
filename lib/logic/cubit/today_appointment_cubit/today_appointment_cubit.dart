import 'package:bloc/bloc.dart';
import 'package:clinic/core/models/appointment_model.dart';
import 'package:clinic/core/services/supabase/appointment_service.dart';
import 'package:flutter/material.dart';

part 'today_appointment_state.dart';

class TodayAppointmentCubit extends Cubit<TodayAppointmentState> {
  TodayAppointmentCubit() : super(TodayAppointmentInitial());

  Future<void> getTodayAppointments({
    required int year,
    required int month,
    required int day,
  }) async {
    emit(TodayAppointmentLoading());

    try {
      final List<AppointmentModel> appointments = await AppointmentService
          .instance
          .getFilteredAppointments(
            year: year,
            month: month,
            day: day,
            isBooked: true,
          );
      emit(TodayAppointmentLoaded(appointments));
    } catch (e, trace) {
      emit(TodayAppointmentFailed('$e\n$trace'));
    }
  }
}
