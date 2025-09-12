import 'package:clinic/core/models/settings_model.dart';
import 'package:hive_flutter/adapters.dart';

class SettingsService {
  static const String boxName = 'settings';
  static late Box<SettingsModel> _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(SettingsModelAdapter().typeId)) {
      Hive.registerAdapter(SettingsModelAdapter());
    }
    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<SettingsModel>(boxName);
    } else {
      _box = Hive.box<SettingsModel>(boxName);
    }
  }

  static SettingsModel getSettings() {
    return _box.get(
      'user_settings',
      defaultValue: SettingsModel(
        isFirstTime: true,
        isLoggedIn: false,
        isDoctor: false,
        userId: '',
        email: '', // اضيف الافتراضي
      ),
    )!;
  }

  static void updateSettings({
    bool? isFirstTime,
    bool? isLoggedIn,
    bool? isDoctor,
    String? userId,
    String? email, // جديد
  }) {
    final settings = getSettings();
    settings.isFirstTime = isFirstTime ?? settings.isFirstTime;
    settings.isLoggedIn = isLoggedIn ?? settings.isLoggedIn;
    settings.isDoctor = isDoctor ?? settings.isDoctor;
    settings.userId = userId ?? settings.userId;
    settings.email = email ?? settings.email; // جديد
    settings.save();
  }
}
