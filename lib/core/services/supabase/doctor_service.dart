import 'package:clinic/core/models/doctor_card_model.dart';
import 'package:clinic/core/models/doctor_profile_model.dart';
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

  Future<Map<String, dynamic>?> getUserData() async {
    final int userId = await UserService().getUserId(email);
    final response =
        await _client
            .from(AppConstants.doctorsTable)
            .select()
            .eq(AppConstants.doctorUserId, userId)
            .maybeSingle();
    return response;
  }

  Future<List<Map<String, dynamic>>> getUsersData() async {
    final response = await _client.from(AppConstants.doctorsTable).select();
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> insertUserData({
    required int specialization,
    required double experienceYear,
    String? clinicAddress,
    required double consultationFee,
    String? imageUrl,
    String? info,
    String? phone,
  }) async {
    final int userId = await UserService().getUserId(email);
    await _client.from(AppConstants.doctorsTable).insert({
      AppConstants.doctorUserId: userId,
      AppConstants.doctorSpecialization: specialization,
      AppConstants.doctorExperience: experienceYear,
      AppConstants.doctorClinicAddress: clinicAddress,
      AppConstants.doctorConsultationFee: consultationFee,
      AppConstants.doctorImageUrl: imageUrl,
      AppConstants.doctorInfo: info,
      AppConstants.doctorPhoneNumber: phone,
    });
  }

  Future<PostgrestResponse> updateUserData({
    int? specialization,
    double? experienceYear,
    String? clinicAddress,
    double? consultationFee,
    String? imageUrl,
    String? info,
    String? phone,
  }) async {
    final int userId = await UserService().getUserId(email);
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
    if (phone != null) updatedData[AppConstants.doctorPhoneNumber] = phone;

    final response = await _client
        .from(AppConstants.doctorsTable)
        .update(updatedData)
        .eq(AppConstants.doctorUserId, userId);
    return response;
  }

  Future<List<DoctorCardModel>> getDoctorsWithRatingCard() async {
    final response = await Supabase.instance.client.rpc(
      'get_doctors_card_info',
    );

    return (response as List)
        .map((json) => DoctorCardModel.fromJson(json))
        .toList();
  }

  Future<DoctorProfileModel> getDoctorProfile(int doctorId) async {
    final response = await _client.rpc(
      'get_doctor_profile_data',
      params: {'doctor_id': doctorId},
    );
    return DoctorProfileModel.fromMap(response[0]);
  }
}
