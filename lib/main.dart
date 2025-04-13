import 'package:clinic/core/services/hive/hive_setting_service.dart';
import 'package:clinic/core/services/supabase/sup_auth_service.dart';
import 'package:clinic/core/utils/app_constants.dart';
import 'package:clinic/my_app.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppConstants.projectURL,
    anonKey: AppConstants.aPIKeyAnon,
    authOptions: const FlutterAuthClientOptions(autoRefreshToken: true),
  );
  await SettingsService.init();
  SupAuthService.instance.initialize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(393, 835),
      builder: (context, child) => const CareSync(),
    ),
  );
}
