// To parse this JSON data, do
//
//     final resRegistrationModel = resRegistrationModelFromJson(jsonString);

import 'dart:convert';

ResRegistrationModel resRegistrationModelFromJson(String str) => ResRegistrationModel.fromJson(json.decode(str));

String resRegistrationModelToJson(ResRegistrationModel data) => json.encode(data.toJson());

class ResRegistrationModel {
  ResRegistrationModel({
    required this.user,
    required this.token,
    required this.message,
    required this.success,
  });

  User user;
  String token;
  String message;
  bool success;

  factory ResRegistrationModel.fromJson(Map<String, dynamic> json) => ResRegistrationModel(
    user: User.fromJson(json["user"]),
    token: json["token"],
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
    "message": message,
    "success": success,
  };
}

class User {
  User({
    this.id,
   this.name,
    this.email,
    this.phoneNumber,
  });

  int? id;
  String? name;
  String? email;
  String? phoneNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
  };
}
