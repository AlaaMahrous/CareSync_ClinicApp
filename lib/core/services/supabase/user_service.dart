import 'package:clinic/core/services/hive/hive_setting_service.dart';
import 'package:clinic/core/utils/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  static final UserService instance = UserService._internal();
  factory UserService() => instance;
  UserService._internal();
  final SupabaseClient _client = Supabase.instance.client;
  final settings = SettingsService.getSettings();

  Future<void> insertUserData({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String userGender,
    required String userRole,
  }) async {
    await _client.from(AppConstants.usersTable).insert({
      AppConstants.userFirstName: firstName,
      AppConstants.userLastName: lastName,
      AppConstants.userEmail: settings.email,
      AppConstants.userBirthDate: birthDate,
      AppConstants.userGender: userGender,
      AppConstants.userUserType: userRole,
    });
  }

  Future<PostgrestResponse> updateUserData({
    required String email,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    String? userGender,
    String? userRole,
  }) async {
    Map<String, dynamic> updatedData = {};
    if (firstName != null) updatedData[AppConstants.userFirstName] = firstName;
    if (lastName != null) updatedData[AppConstants.userLastName] = lastName;
    if (birthDate != null) updatedData[AppConstants.userBirthDate] = birthDate;
    if (userGender != null) updatedData[AppConstants.userGender] = userGender;
    if (userRole != null) updatedData[AppConstants.userUserType] = userRole;
    final response = await _client
        .from(AppConstants.usersTable)
        .update(updatedData)
        .eq(AppConstants.userEmail, email);
    return response;
  }

  Future<int> getUserId(String userEmail) async {
    final userId =
        await _client
            .from(AppConstants.usersTable)
            .select(AppConstants.userId)
            .eq(AppConstants.userEmail, userEmail)
            .maybeSingle();
    return userId?[AppConstants.userId];
  }

  Future<String> getUserType(String userEmail) async {
    final userType =
        await _client
            .from(AppConstants.usersTable)
            .select(AppConstants.userUserType)
            .eq(AppConstants.userEmail, userEmail)
            .maybeSingle();

    return userType?[AppConstants.userUserType];
  }

  Future<void> updateFcmTokenByEmail({
    required String email,
    required String fcmToken,
  }) async {
    await _client
        .from('Users')
        .update({'fcm_token': fcmToken})
        .eq('email', email);
  }
}
