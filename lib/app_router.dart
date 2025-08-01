import 'package:clinic/core/models/doctor_profile_model.dart';
import 'package:clinic/core/services/hive/hive_setting_service.dart';
import 'package:clinic/logic/auth/sup_auth_service.dart';
import 'package:clinic/logic/cubit/doctor_profile_cubit/doctor_profile_cubit.dart';
import 'package:clinic/presentation/clinic_app.dart';
import 'package:clinic/presentation/doctor_app.dart';
import 'package:clinic/presentation/patient_app.dart';
import 'package:clinic/presentation/screens/auth/login_screen.dart';
import 'package:clinic/presentation/screens/auth/sign_up_screen.dart';
import 'package:clinic/presentation/screens/doctor/doctor_dashboard_screen.dart';
import 'package:clinic/presentation/screens/doctor/doctor_details_form_screen.dart';
import 'package:clinic/presentation/screens/doctor/doctor_schedule_screen.dart';
import 'package:clinic/presentation/screens/doctor/doctor_sessions_screen.dart';
import 'package:clinic/presentation/screens/onboarding_screen.dart';
import 'package:clinic/presentation/screens/patient/patient_home_screen.dart';
import 'package:clinic/presentation/screens/user_details_screen.dart';
import 'package:clinic/presentation/widgets/edit_doctor_details_screen_body.dart';
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
        path: DoctorDetailsFormScreen.path,
        builder: (context, state) => const DoctorDetailsFormScreen(),
      ),
      GoRoute(
        path: ClinicApp.path,
        builder: (context, state) {
          final settings = SettingsService.getSettings();
          return ClinicApp(isDoctor: settings.isDoctor);
        },
      ),
      GoRoute(
        path: DoctorApp.path,
        builder: (context, state) => const DoctorApp(),
      ),
      GoRoute(
        path: PatientApp.path,
        builder: (context, state) => const PatientApp(),
      ),
      GoRoute(
        path: DoctorDashboardScreen.path,
        builder: (context, state) => const DoctorDashboardScreen(),
      ),
      GoRoute(
        path: PatientHomeScreen.path,
        builder: (context, state) => const PatientHomeScreen(),
      ),
      GoRoute(
        path: EditDoctorDetailsScreenBody.path,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final doctorModel = data['doctorModel'] as DoctorProfileModel;
          final editCubit = data['editCubit'] as DoctorProfileCubit;
          return EditDoctorDetailsScreenBody(
            doctorModel: doctorModel,
            editCubit: editCubit,
          );
        },
      ),
      GoRoute(
        path: DoctorScheduleScreen.path,
        builder: (context, state) => const DoctorScheduleScreen(),
      ),
      GoRoute(
        path: DoctorSessionsScreen.path,
        builder: (context, state) => const DoctorSessionsScreen(),
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
    return ClinicApp.path;
  }

  static String? _checkSession() {
    if (!isLoggedIn && !settings.isFirstTime) {
      return LoginScreen.path;
    }
    return null;
  }
}
