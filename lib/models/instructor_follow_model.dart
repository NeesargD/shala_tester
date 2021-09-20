// To parse this JSON data, do
//
//     final instructorFollowModel = instructorFollowModelFromJson(jsonString);

import 'dart:convert';

InstructorFollowModel instructorFollowModelFromJson(String str) => InstructorFollowModel.fromJson(json.decode(str));

String instructorFollowModelToJson(InstructorFollowModel data) => json.encode(data.toJson());

class InstructorFollowModel {
  InstructorFollowModel({
    this.instructor,
    this.success,
    this.message,
  });

  Instructor? instructor;
  bool? success;
  String? message;

  factory InstructorFollowModel.fromJson(Map<String, dynamic> json) => InstructorFollowModel(
    instructor: Instructor.fromJson(json["instructor"]),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "instructor": instructor!.toJson(),
    "success": success,
    "message": message,
  };
}

class Instructor {
  Instructor({
    this.id,
    this.firstname,
    this.lastname,
    this.languages,
    this.style,
    this.country,
    this.state,
    this.description,
    this.profilePicture,
    this.follower,
    this.program,
    this.classes,
  });

  int? id;
  String? firstname;
  String? lastname;
  List<String>? languages;
  List<String>? style;
  String? country;
  String? state;
  String? description;
  String? profilePicture;
  int? follower;
  int? program;
  int? classes;

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    languages: List<String>.from(json["languages"].map((x) => x)),
    style: List<String>.from(json["style"].map((x) => x)),
    country: json["country"],
    state: json["state"],
    description: json["description"],
    profilePicture: json["profile_picture"],
    follower: json["follower"],
    program: json["program"],
    classes: json["classes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "languages": List<dynamic>.from(languages!.map((x) => x)),
    "style": List<dynamic>.from(style!.map((x) => x)),
    "country": country,
    "state": state,
    "description": description,
    "profile_picture": profilePicture,
    "follower": follower,
    "program": program,
    "classes": classes,
  };
}
