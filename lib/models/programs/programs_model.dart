// To parse this JSON data, do
//
//     final programsModel = programsModelFromJson(jsonString);

import 'dart:convert';

import '../instructor_models.dart';

ProgramsModel programsModelFromJson(String str) => ProgramsModel.fromJson(json.decode(str));

String programsModelToJson(ProgramsModel data) => json.encode(data.toJson());

class ProgramsModel {
  ProgramsModel({
    this.content,
    required this.success,
    required this.message,
  });

  Content? content;
  bool success;
  String message;

  factory ProgramsModel.fromJson(Map<String, dynamic> json) => ProgramsModel(
    content: json["content"] == null ? null : Content.fromJson(json["content"]),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "content": content == null ? null : content!.toJson(),
    "success": success,
    "message": message,
  };
}

class Content {
  Content({
    required this.programs,
  });

  List<Program> programs;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    programs: json["programs"] == null ? [] : List<Program>.from(json["programs"].map((x) => Program.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "programs": List<dynamic>.from(programs.map((x) => x.toJson())),
  };
}

class Program {
  Program({
    required this.id,
    required this.instructor,
    required this.title,
    required this.style,
    required this.focus,
    required this.level,
    required this.languages,
    required this.count,
    required this.coverImage,
    required this.teaserVideoUrl,
  });

  int id;
  Instructor instructor;
  String title;
  List<String> style;
  List<String> focus;
  List<String> level;
  List<String> languages;
  int count;
  String coverImage;
  String teaserVideoUrl;

  factory Program.fromJson(Map<String, dynamic> json) => Program(
    id: json["id"] == null ? null : json["id"],
    instructor: Instructor.fromJson(json["instructor"]),
    title: json["title"] == null ? '' : json["title"],
    style: json["style"] == null ? [] : List<String>.from(json["style"].map((x) => x)),
    focus: json["focus"] == null ? [] : List<String>.from(json["focus"].map((x) => x)),
    level: json["level"] == null ? [] : List<String>.from(json["level"].map((x) => x)),
    languages: json["languages"] == null ? [] : List<String>.from(json["languages"].map((x) => x)),
    count: json["count"] == null ? 0 : json["count"],
    coverImage: json["cover_Image"] == null ? '' : json["cover_Image"],
    teaserVideoUrl: json["teaser_Video_Url"] == null ? '' : json["teaser_Video_Url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "instructor": instructor.toJson(),
    "title": title,
    "style": List<dynamic>.from(style.map((x) => x)),
    "focus": List<dynamic>.from(focus.map((x) => x)),
    "level": List<dynamic>.from(level.map((x) => x)),
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "count": count,
    "cover_Image": coverImage,
    "teaser_Video_Url": teaserVideoUrl,
  };
}

/*class Instructor {
  Instructor({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.languages,
    required this.style,
    required this.profilePicture,
  });

  int id;
  String firstname;
  String lastname;
  List<String> languages;
  List<String> style;
  String profilePicture;

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
    id: json["id"] == null ? null : json["id"],
    firstname: json["firstname"] == null ? null : json["firstname"],
    lastname: json["lastname"] == null ? null : json["lastname"],
    languages: json["languages"] == null ? null : List<String>.from(json["languages"].map((x) => x)),
    style: json["style"] == null ? null : List<String>.from(json["style"].map((x) => x)),
    profilePicture: json["profile_picture"] == null ? null : json["profile_picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "firstname": firstname == null ? null : firstname,
    "lastname": lastname == null ? null : lastname,
    "languages": languages == null ? null : List<dynamic>.from(languages.map((x) => x)),
    "style": style == null ? null : List<dynamic>.from(style.map((x) => x)),
    "profile_picture": profilePicture == null ? null : profilePicture,
  };
}*/
