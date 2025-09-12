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
    try {
      await _supabase.auth.signOut(); // دي async، فهيستنى الطلب يخلص
      log("signOut() called and awaited");

      // استنى شوية عشان الـ listener يشتغل، أو تحقق يدويًا
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // optional، بس مفيد لو في تأخير

      // تحقق يدويًا من السيشن بعد الانتظار
      if (_supabase.auth.currentSession != null) {
        log(
          "Warning: Session still exists after signOut! Trying to recover...",
        );
        // لو لسة موجود، ممكن تنادي refresh أو clear manual
        // بس عادةً الlistener هيحلها
      } else {
        log("Session cleared successfully");
      }

      // الlistener هيحدث الnotifier تلقائيًا، بس لو عايز تتأكد، حدثه هنا
      authStateNotifier.value = _supabase.auth.currentSession != null;
    } catch (e) {
      log("Error during signOut: $e");
      // لو في خطأ، حدث الnotifier يدويًا
      authStateNotifier.value = false;
    }
  }
}
