// To parse this JSON data, do
//
//     final resLoginModel = resLoginModelFromJson(jsonString);

import 'dart:convert';

ResLoginModel resLoginModelFromJson(String str) => ResLoginModel.fromJson(json.decode(str));

String resLoginModelToJson(ResLoginModel data) => json.encode(data.toJson());

class ResLoginModel {
  ResLoginModel({
    required this.user,
    required this.success,
    required this.message,
    required this.token,
  });

  User user;
  bool success;
  String message;
  String token;

  factory ResLoginModel.fromJson(Map<String, dynamic> json) => ResLoginModel(
        user: User.fromJson(json["user"]),
        success: json["success"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "success": success,
        "message": message,
        "token": token,
      };
}

class User {
  User({this.name, this.email, this.phone, this.id});

  int? id;
  String? name;
  String? email;
  String? phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "email": email,
        "phone": phone,
      };
}
