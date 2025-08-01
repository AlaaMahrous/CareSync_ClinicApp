import 'dart:developer';

import 'package:clinic/core/models/appointment_counts_model.dart';
import 'package:clinic/core/models/appointment_model.dart';
import 'package:clinic/core/services/hive/hive_setting_service.dart';
import 'package:clinic/core/utils/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentService {
  static final AppointmentService instance = AppointmentService._internal();
  factory AppointmentService() => instance;
  AppointmentService._internal();
  final SupabaseClient _client = Supabase.instance.client;
  final settings = SettingsService.getSettings();

  /// Add new appointment (by doctor)
  Future<void> addAppointment({
    required DateTime availableDate,
    required int duration,
  }) async {
    await _client.from(AppConstants.appointmentsTable).insert({
      AppConstants.appointmentDoctorId: settings.userId,
      AppConstants.appointmentAvailableDate: availableDate.toIso8601String(),
      AppConstants.appointmentDuration: duration,
    });
  }

  /// Get appointments for a specific doctor
  Future<List<Map<String, dynamic>>> getDoctorAppointments(int doctorId) async {
    final response = await _client
        .from(AppConstants.appointmentsTable)
        .select()
        .eq(AppConstants.appointmentDoctorId, doctorId)
        .order(AppConstants.appointmentAvailableDate, ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Update appointment by ID (only date and duration)
  Future<void> updateAppointment({
    required int appointmentId,
    required DateTime availableDate,
    required int duration,
  }) async {
    await _client
        .from(AppConstants.appointmentsTable)
        .update({
          AppConstants.appointmentAvailableDate:
              availableDate.toIso8601String(),
          AppConstants.appointmentDuration: duration,
        })
        .eq(AppConstants.appointmentId, appointmentId);
  }

  // get Filtered Appointments
  Future<List<AppointmentModel>> getFilteredAppointments({
    required int year,
    required int month,
    required int day,
    bool? isBooked,
  }) async {
    try {
      final response =
          await _client
              .rpc(
                'get_filtered_appointments',
                params: {
                  'p_year': year,
                  'p_month': month,
                  'p_day': day,
                  'p_doctor_id': settings.userId,
                  if (isBooked != null) 'p_is_booked': isBooked,
                },
              )
              .select();
      final appointments =
          List<Map<String, dynamic>>.from(
            response,
          ).map((json) => AppointmentModel.fromJson(json)).toList();

      log('Fetched ${appointments.length} appointments for $year-$month-$day:');
      for (var appt in appointments) {
        log('Appointment ID: ${appt.id}, Date: ${appt.availableDate}');
      }
      return appointments;
    } catch (e) {
      log('Error fetching appointments: $e');
      throw Exception('Failed to fetch appointments: $e');
    }
  }

  /// Book an appointment (patient selects one)
  Future<void> bookAppointment({
    required int appointmentId,
    required int patientId,
  }) async {
    await _client
        .from(AppConstants.appointmentsTable)
        .update({
          AppConstants.appointmentPatientId: patientId,
          AppConstants.appointmentIsBooked: true,
        })
        .eq(AppConstants.appointmentId, appointmentId);
  }

  /// Cancel a booking (makes appointment available again)
  Future<void> cancelAppointment(int appointmentId) async {
    await _client
        .from(AppConstants.appointmentsTable)
        .update({
          AppConstants.appointmentPatientId: null,
          AppConstants.appointmentIsBooked: false,
        })
        .eq(AppConstants.appointmentId, appointmentId);
  }

  /// Delete appointment (optional, mostly by doctor)
  Future<void> deleteAppointment(int appointmentId) async {
    await _client
        .from(AppConstants.appointmentsTable)
        .delete()
        .eq(AppConstants.appointmentId, appointmentId);
  }

  /// Get appointment by ID
  Future<Map<String, dynamic>?> getAppointmentById(int id) async {
    final response =
        await _client
            .from(AppConstants.appointmentsTable)
            .select()
            .eq(AppConstants.appointmentId, id)
            .single();

    return response;
  }

  // Check the appointment overlapping
  bool isOverlapping({
    required List<AppointmentModel> existingAppointments,
    required DateTime newStart,
    required int newDurationMinutes,
  }) {
    DateTime newEnd = newStart.add(Duration(minutes: newDurationMinutes));

    for (AppointmentModel appointment in existingAppointments) {
      DateTime existingStart = appointment.availableDate;
      DateTime existingEnd = existingStart.add(
        Duration(minutes: appointment.duration),
      );
      if (!(newEnd.isBefore(existingStart) ||
          newEnd.isAtSameMomentAs(existingStart) ||
          existingEnd.isBefore(newStart) ||
          existingEnd.isAtSameMomentAs(newStart))) {
        return true;
      }
    }

    return false;
  }

  Future<AppointmentCountsModel> fetchAppointmentCounts({
    required int year,
    required int month,
    required int doctorId,
  }) async {
    final response = await _client.rpc(
      'get_appointment_counts',
      params: {
        'year_param': year,
        'month_param': month,
        'doctor_id_param': doctorId,
      },
    );

    return AppointmentCountsModel.fromMap(response[0]);
  }
}
