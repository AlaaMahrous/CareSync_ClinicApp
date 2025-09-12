import 'package:hive_flutter/adapters.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 0)
class SettingsModel extends HiveObject {
  @HiveField(0)
  bool isFirstTime;

  @HiveField(1)
  bool isLoggedIn;

  @HiveField(2)
  bool isDoctor;

  @HiveField(3)
  String userId;

  @HiveField(4) // حقل جديد للإيميل
  String email;

  SettingsModel({
    required this.isFirstTime,
    required this.isLoggedIn,
    required this.isDoctor,
    required this.userId,
    required this.email,
  });
}
