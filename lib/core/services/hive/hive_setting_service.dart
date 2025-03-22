import 'package:clinic/core/models/settings_model.dart';
import 'package:hive_flutter/adapters.dart';

class SettingsService {
  static const String boxName = 'settings';
  static late Box<SettingsModel> _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SettingsModelAdapter());
    _box = await Hive.openBox<SettingsModel>(boxName);
  }

  static SettingsModel getSettings() {
    return _box.get(
      'user_settings',
      defaultValue: SettingsModel(
        isFirstTime: true,
        isLoggedIn: false,
        isDoctor: false,
      ),
    )!;
  }

  static void updateSettings({
    bool? isFirstTime,
    bool? isLoggedIn,
    bool? isDoctor,
  }) {
    final settings = getSettings();
    settings.isFirstTime = isFirstTime ?? settings.isFirstTime;
    settings.isLoggedIn = isLoggedIn ?? settings.isLoggedIn;
    settings.isDoctor = isDoctor ?? settings.isDoctor;
    settings.save();
  }
}
