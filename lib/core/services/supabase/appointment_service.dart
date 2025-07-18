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

  /// Get appointments for a specific patient
  Future<List<Map<String, dynamic>>> getPatientAppointments(
    int patientId,
  ) async {
    final response = await _client
        .from(AppConstants.appointmentsTable)
        .select()
        .eq(AppConstants.appointmentPatientId, patientId)
        .order(AppConstants.appointmentAvailableDate, ascending: true);
    return List<Map<String, dynamic>>.from(response);
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
}
