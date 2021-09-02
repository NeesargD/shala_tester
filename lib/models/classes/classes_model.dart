import 'dart:convert';

import '../instructor_models.dart';

ClassesModel classesModelFromJson(String str) =>
    ClassesModel.fromJson(json.decode(str));

String classesModelToJson(ClassesModel data) => json.encode(data.toJson());

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
      languages: json["languages"] == null
      ? []
          : List<String>.from(json["languages"].map((x) => x)),
  style: json["style"] == null
  ? []
      : List<String>.from(json["style"].map((x) => x)),
  profilePicture:
  json["profile_picture"] == null ? null : json["profile_picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "style": List<dynamic>.from(style.map((x) => x)),
    "profile_picture": profilePicture,
  };
}*/

class ClassesModel {
  ClassesModel({
    required this.content,
    required this.success,
    required this.message,
  });

  Content? content;
  bool success;
  String message;

  factory ClassesModel.fromJson(Map<String, dynamic> json) => ClassesModel(
    content:
    json["content"] == null ? null : Content.fromJson(json["content"]),
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
    required this.classes,
  });

  List<Class> classes;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
      classes: json["classes"] == null
      ? []
          : List<Class>.from(json["classes"].map((x) => Class.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
  };
}

class Class {
  Class({
    required this.id,
    required this.instructor,
    required this.title,
    required this.focus,
    required this.style,
    required this.level,
    required this.language,
    required this.durations,
    required this.videoUrl,
    required this.coverImage,
    required this.isLock,
  });

  int id;
  Instructor instructor;
  String title;
  List<String> focus;
  List<String> style;
  String level;
  String language;
  String durations;
  String videoUrl;
  String coverImage;
  bool isLock;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
      id: json["id"] == null ? null : json["id"],
      instructor: Instructor.fromJson(json["instructor"]),
      title: json["title"] == null ? '' : json["title"],
      focus: json["focus"] == null
      ? []
          : List<String>.from(json["focus"].map((x) => x)),
  style: json["style"] == null
  ? []
      : List<String>.from(json["style"].map((x) => x)),
  level: json["level"] == null ? '' : json["level"],
  language: json["language"] == null ? '' : json["language"],
  durations: json["durations"] == null ? '' : json["durations"],
  videoUrl: json["video_url"] == null ? '' : json["video_url"],
  coverImage: json["cover_image"] == null ? '' : json["cover_image"],
  isLock: json["is_lock"] == null ? true : json["is_lock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "instructor": instructor.toJson(),
    "title": title,
    "focus": List<dynamic>.from(focus.map((x) => x)),
    "style": List<dynamic>.from(style.map((x) => x)),
    "level": level,
    "language": language,
    "durations": durations,
    "video_url": videoUrl,
    "cover_image": coverImage,
    "is_lock": isLock,
  };
}
