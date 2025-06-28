import 'package:clinic/core/utils/app_constants.dart';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String userType;
  final DateTime birthDate;
  final String email;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.userType,
    required this.birthDate,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[AppConstants.userId],
      firstName: json[AppConstants.userFirstName],
      lastName: json[AppConstants.userLastName],
      gender: json[AppConstants.userGender],
      userType: json[AppConstants.userUserType],
      birthDate: DateTime.parse(json[AppConstants.userBirthDate]),
      email: json[AppConstants.userEmail],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.userId: id,
      AppConstants.userFirstName: firstName,
      AppConstants.userLastName: lastName,
      AppConstants.userGender: gender,
      AppConstants.userUserType: userType,
      AppConstants.userBirthDate: birthDate.toIso8601String(),
      AppConstants.userEmail: email,
    };
  }
}
