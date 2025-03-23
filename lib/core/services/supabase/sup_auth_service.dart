import 'package:clinic/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupAuthService {
  static final SupAuthService instance = SupAuthService._internal();
  factory SupAuthService() => instance;
  SupAuthService._internal();

  final SupabaseClient _supabase = Supabase.instance.client;
  final ValueNotifier<bool> authStateNotifier = ValueNotifier<bool>(false);

  void initialize() {
    authStateNotifier.value = _supabase.auth.currentSession != null;
    _supabase.auth.onAuthStateChange.listen((event) {
      authStateNotifier.value = event.session != null;
    });
  }

  bool get isLoggedIn => _supabase.auth.currentSession != null;

  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );
    authStateNotifier.value = response.session != null;
    return response;
  }

  Future<AuthResponse> logInWithEmail(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    authStateNotifier.value = response.session != null;
    return response;
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    authStateNotifier.value = false;
  }

  String? getCurrentUserEmail() {
    final Session? session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  Future<String> getCurrentUserId(String userEmail) async {
    final userId =
        await Supabase.instance.client
            .from(AppConstants.usersTable)
            .select(AppConstants.userId)
            .eq(AppConstants.userEmail, userEmail)
            .maybeSingle();
    return userId?[AppConstants.userId];
  }

  Future<String> getCurrentUserType(String userEmail) async {
    final userType =
        await Supabase.instance.client
            .from(AppConstants.usersTable)
            .select(AppConstants.userUserType)
            .eq(AppConstants.userEmail, userEmail)
            .maybeSingle();
    return userType?[AppConstants.userUserType];
  }
}
