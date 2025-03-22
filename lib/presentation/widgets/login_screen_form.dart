import 'package:clinic/core/services/supabase/sup_auth_service.dart';
import 'package:clinic/core/utils/show_snack_bar.dart';
import 'package:clinic/presentation/screens/user_details_screen.dart';
import 'package:clinic/presentation/widgets/login_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: LoginScreenBody(
          emailOnSaved: (value) {
            email = value;
          },
          emailValidator: (value) {
            return null;
          },
          passwordOnSaved: (value) {
            password = value;
          },
          passwordValidator: (value) {
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
          if (mounted) {
            GoRouter.of(context).replace(UserDetailsScreen.path);
          }
        } else {
          _showError("Sign up failed. Please try again.");
        }
      } catch (e) {
        _showError(e.toString());
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

  void _showError(String message) {
    showMessage(context, message, Colors.red);
  }
}
