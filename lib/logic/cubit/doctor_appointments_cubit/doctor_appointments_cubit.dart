import 'package:bloc/bloc.dart';
import 'package:clinic/core/models/appointment_model.dart';
import 'package:clinic/core/services/supabase/appointment_service.dart';
import 'package:meta/meta.dart';

part 'doctor_appointments_state.dart';

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  DoctorAppointmentsCubit() : super(DoctorAppointmentsInitial());

  Future<void> getFilteredAppointments({
    required int year,
    required int month,
    required int day,
    bool? isBooked,
  }) async {
    emit(DoctorAppointmentsLoading());

    try {
      final List<AppointmentModel> appointments = await AppointmentService
          .instance
          .getFilteredAppointments(
            year: year,
            month: month,
            day: day,
            isBooked: isBooked,
          );

      emit(DoctorAppointmentsLoaded(appointments));
    } catch (e) {
      emit(DoctorAppointmentsFailure(e.toString()));
    }
  }
}
