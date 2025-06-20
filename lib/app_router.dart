import 'package:clinic/core/services/hive/hive_setting_service.dart';
import 'package:clinic/logic/auth/sup_auth_service.dart';
import 'package:clinic/presentation/clinic_app.dart';
import 'package:clinic/presentation/screens/auth/login_screen.dart';
import 'package:clinic/presentation/screens/auth/sign_up_screen.dart';
import 'package:clinic/presentation/screens/doctor_details_screen.dart';
import 'package:clinic/presentation/screens/doctor_home_screen.dart';
import 'package:clinic/presentation/screens/onboarding_screen.dart';
import 'package:clinic/presentation/screens/patient_home_screen.dart';
import 'package:clinic/presentation/screens/user_details_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final settings = SettingsService.getSettings();
  static final isLoggedIn = SupAuthService.instance.isLoggedIn;
  static final router = GoRouter(
    initialLocation: _getInitialLocation(),
    routes: [
      GoRoute(
        path: OnboardingScreen.path,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: LoginScreen.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: SignUpScreen.path,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: UserDetailsScreen.path,
        builder: (context, state) => const UserDetailsScreen(),
      ),
      GoRoute(
        path: DoctorDetailsScreen.path,
        builder: (context, state) => const DoctorDetailsScreen(),
      ),
      GoRoute(
        path: ClinicApp.path,
        builder: (context, state) {
          final settings = SettingsService.getSettings();
          return ClinicApp(isDoctor: settings.isDoctor);
        },
      ),
      GoRoute(
        path: DoctorHomeScreen.path,
        builder: (context, state) => const DoctorHomeScreen(),
      ),
      GoRoute(
        path: PatientHomeScreen.path,
        builder: (context, state) => const PatientHomeScreen(),
      ),
    ],
    redirect: (context, state) => _checkSession(),
  );

  static String _getInitialLocation() {
    if (settings.isFirstTime) {
      return OnboardingScreen.path;
    }
    if (!SupAuthService.instance.isLoggedIn) {
      return LoginScreen.path;
    }
    return settings.isDoctor ? DoctorHomeScreen.path : ClinicApp.path;
  }

  static String? _checkSession() {
    if (!isLoggedIn && !settings.isFirstTime) {
      return LoginScreen.path;
    }
    return null;
  }
}
