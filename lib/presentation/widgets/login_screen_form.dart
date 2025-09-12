// ignore_for_file: unused_import

import 'package:clinic/core/services/hive/hive_setting_service.dart';
import 'package:clinic/core/services/supabase/doctor_service.dart';
import 'package:clinic/core/services/supabase/user_service.dart';
import 'package:clinic/core/utils/app_constants.dart';
import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/show_snack_bar.dart';
import 'package:clinic/logic/auth/sup_auth_service.dart';
import 'package:clinic/presentation/clinic_app.dart';
import 'package:clinic/presentation/doctor_app.dart';
import 'package:clinic/presentation/patient_app.dart';
import 'package:clinic/presentation/screens/user_details_screen.dart';
import 'package:clinic/presentation/widgets/login_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreenForm extends StatefulWidget {
  const LoginScreenForm({super.key});

  @override
  State<LoginScreenForm> createState() => _LoginScreenFormState();
}

class _LoginScreenFormState extends State<LoginScreenForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool obscure = true;
  String? email;
  String? password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: ColorsManager.mainAppColor,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: LoginScreenBody(
          emailOnSaved: (value) {
            email = value;
          },
          emailValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            } else if (!value.endsWith('@gmail.com')) {
              return 'Email must end with @gmail.com';
            }
            return null;
          },
          passwordOnSaved: (value) {
            password = value!;
          },
          passwordValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            return null;
          },
          suffixPasswordIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                obscure = !obscure;
              });
            },
          ),
          obscurePasswordText: obscure,
          onForgetPasswordTap: () {},
          onLoginTap: _loginMethod,
        ),
      ),
    );
  }

  void _loginMethod() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await SupAuthService.instance.logInWithEmail(
          email!,
          password!,
        );
        if (response.session != null) {
          String userEmail = email!;
          SettingsService.updateSettings(email: email);
          if (userEmail.isNotEmpty) {
            final userType = await UserService.instance.getUserType(userEmail);
            String userId;
            if (userType == AppConstants.doctor) {
              Map<String, dynamic>? doctorData =
                  await DoctorService.instance.getDoctorData();
              userId = doctorData![AppConstants.doctorId].toString();
              SettingsService.updateSettings(isDoctor: true, userId: userId);
              if (mounted) {
                _showError("Login successful!");
                GoRouter.of(context).go(ClinicApp.path);
              }
            } else {
              userId = UserService.instance.getUserId(userEmail).toString();
              SettingsService.updateSettings(isDoctor: false, userId: userId);
              if (mounted) {
                _showError("Login successful!");
                GoRouter.of(context).go(ClinicApp.path);
              }
            }
          }
        }
      } on AuthException catch (e) {
        debugPrint("AuthException: ${e.message}");
        _handleAuthError(e.message);
      } catch (e) {
        _showError("Login failed, an error occurred: ${e.toString()}");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void _handleAuthError(String errorMessage) {
    if (errorMessage.contains("Invalid login credentials")) {
      _showError("Incorrect email or password.");
    } else if (errorMessage.contains("User not found")) {
      _showError("No account found with this email.");
    } else if (errorMessage.contains("User is not confirmed")) {
      _showError("Your account is not confirmed. Please check your email.");
    } else if (errorMessage.contains("SocketException") ||
        errorMessage.toLowerCase().contains("connection") ||
        errorMessage.toLowerCase().contains("network error")) {
      _showError("No internet connection. Please check your network.");
    } else {
      _showError("Authentication error: $errorMessage");
    }
  }

  void _showError(String message) {
    showMessage(context, message, ColorsManager.mainAppColor);
  }
}
