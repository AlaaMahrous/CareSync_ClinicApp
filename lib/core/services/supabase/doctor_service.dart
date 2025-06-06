import 'package:clinic/core/services/supabase/user_service.dart';
import 'package:clinic/core/utils/app_constants.dart';
import 'package:clinic/logic/auth/sup_auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorService {
  static final DoctorService instance = DoctorService._internal();
  factory DoctorService() => instance;
  DoctorService._internal();
  final SupabaseClient _client = Supabase.instance.client;
  final String email = SupAuthService.instance.getCurrentUserEmail()!;

  Future<void> insertUserData({
    required int specialization,
    required int experienceYear,
    String? clinicAddress,
    required double consultationFee,
    String? imageUrl,
    String? info,
  }) async {
    final String userId = await UserService().getUserId(email);
    await _client.from(AppConstants.doctorsTable).insert({
      AppConstants.doctorUserId: userId,
      AppConstants.doctorSpecialization: specialization,
      AppConstants.doctorExperience: experienceYear,
      AppConstants.doctorClinicAddress: clinicAddress,
      AppConstants.doctorConsultationFee: consultationFee,
      AppConstants.doctorImageUrl: imageUrl,
      AppConstants.doctorInfo: info,
    });
  }

  Future<PostgrestResponse> updateUserData({
    int? specialization,
    int? experienceYear,
    String? clinicAddress,
    double? consultationFee,
    String? imageUrl,
    String? info,
  }) async {
    final String userId = await UserService().getUserId(email);
    Map<String, dynamic> updatedData = {};
    if (specialization != null) {
      updatedData[AppConstants.doctorSpecialization] = specialization;
    }
    if (experienceYear != null) {
      updatedData[AppConstants.doctorExperience] = experienceYear;
    }
    if (clinicAddress != null) {
      updatedData[AppConstants.doctorClinicAddress] = clinicAddress;
    }
    if (consultationFee != null) {
      updatedData[AppConstants.doctorConsultationFee] = consultationFee;
    }
    if (imageUrl != null) updatedData[AppConstants.doctorImageUrl] = imageUrl;
    if (info != null) updatedData[AppConstants.doctorInfo] = info;

    final response = await _client
        .from(AppConstants.doctorsTable)
        .update(updatedData)
        .eq(AppConstants.doctorUserId, userId);
    return response;
  }
}
