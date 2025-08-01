import 'dart:developer';

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
    log("Signed out successfully");
  }

  String? getCurrentUserEmail() {
    log("${_supabase.auth.currentSession}");
    log("${_supabase.auth.currentUser}");
    final Session? session = _supabase.auth.currentSession;
    if (session == null) {
      log("No active session");
      return null;
    }
    return session.user.email;
  }

  String? getCurrentUserId() {
    final Session? session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }
}
