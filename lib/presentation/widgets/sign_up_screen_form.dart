import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/show_snack_bar.dart';
import 'package:clinic/logic/auth/sup_auth_service.dart';
import 'package:clinic/presentation/screens/user_details_screen.dart';
import 'package:clinic/presentation/widgets/sign_up_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreenForm extends StatefulWidget {
  const SignUpScreenForm({super.key});

  @override
  State<SignUpScreenForm> createState() => _SignUpScreenFormState();
}

class _SignUpScreenFormState extends State<SignUpScreenForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController _passwordController = TextEditingController();
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
        child: SignUpScreenBody(
          emailOnSaved: (value) => email = value,
          emailValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            } else if (!value.endsWith('@gmail.com')) {
              return 'Email must end with @gmail.com';
            }
            return null;
          },
          passwordController: _passwordController,
          passwordOnSaved: (value) => password = value,
          passwordValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          confirmPasswordValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Confirm password is required';
            } else if (value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          suffixPasswordIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => obscure = !obscure),
          ),
          obscurePasswordText: obscure,
          onSignUpTap: _signUpMethod,
        ),
      ),
    );
  }

  void _signUpMethod() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.always);
      return;
    }
    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    try {
      final response = await SupAuthService.instance.signUpWithEmail(
        email!,
        password!,
      );
      if (response.session != null) {
        _showError("Sign up successful!");
        if (mounted) {
          GoRouter.of(context).go(UserDetailsScreen.path);
        }
      } else {
        _showError("Sign up failed. Please try again.");
      }
    } on AuthException catch (e) {
      debugPrint("AuthException: ${e.message}");
      _handleAuthError(e.message);
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleAuthError(String errorMessage) {
    if (errorMessage.contains("email already in use")) {
      _showError("This email is already registered.");
    } else if (errorMessage.contains("invalid email")) {
      _showError("Please enter a valid email address.");
    } else if (errorMessage.contains("weak password")) {
      _showError("Your password is too weak. Try using a stronger one.");
    } else if (errorMessage.contains("SocketException") ||
        errorMessage.toLowerCase().contains("connection") ||
        errorMessage.toLowerCase().contains("network error")) {
      _showError("No internet connection. Please check your network.");
    } else {
      _showError("Sign-up error: $errorMessage");
    }
  }

  void _showError(String message) {
    if (mounted) {
      showMessage(context, message, ColorsManager.mainAppColor);
    }
  }
}
