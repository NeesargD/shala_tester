// To parse this JSON data, do
//
//     final getFilterModel = getFilterModelFromJson(jsonString);

import 'dart:convert';

GetFilterModel getFilterModelFromJson(String str) => GetFilterModel.fromJson(json.decode(str));

String getFilterModelToJson(GetFilterModel data) => json.encode(data.toJson());

class GetFilterModel {
  GetFilterModel({
    required this.content,
    required this.success,
    required this.message,
  });

  Content content;
  bool success;
  String message;

  factory GetFilterModel.fromJson(Map<String, dynamic> json) => GetFilterModel(
        content: Content.fromJson(json["content"]),
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "content":  content.toJson(),
        "success":  success,
        "message":  message,
      };
}

class Content {
  Content({
    required this.language,
    required this.level,
    required this.style,
    required this.focus,
    required this.instructor,
  });

  List<Language> language;
  List<Level> level;
  List<Style> style;
  List<Focus> focus;
  List<Instructor> instructor;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        language: json["language"] == null ? [] : List<Language>.from(json["language"].map((x) => Language.fromJson(x))),
        level: json["level"] == null ? [] : List<Level>.from(json["level"].map((x) => Level.fromJson(x))),
        style: json["style"] == null ? [] : List<Style>.from(json["style"].map((x) => Style.fromJson(x))),
        focus: json["focus"] == null ? [] : List<Focus>.from(json["focus"].map((x) => Focus.fromJson(x))),
        instructor: json["instructor"] == null ? [] : List<Instructor>.from(json["instructor"].map((x) => Instructor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "language":  List<dynamic>.from(language.map((x) => x.toJson())),
        "level":  List<dynamic>.from(level.map((x) => x.toJson())),
        "style":  List<dynamic>.from(style.map((x) => x.toJson())),
    "focus":  List<dynamic>.from(focus.map((x) => x.toJson())),
    "instructor":  List<dynamic>.from(instructor.map((x) => x.toJson())),
  };
}

class Focus {
  Focus({
    required this.id,
    required this.focusTitle,
    this.isSelected = false,
  });
  int id;
  String focusTitle;
  bool isSelected;

  factory Focus.fromJson(Map<String, dynamic> json) => Focus(
        id: json["id"],
        focusTitle: json["focus_title"] == null ? null : json["focus_title"],
      );

  Map<String, dynamic> toJson() => {
        "id":id,
        "focus_title": focusTitle,
      };
}

class Instructor {
  Instructor({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.languages,
    required this.style,
    this.isSelected = false,
    required this.profilePicture,
  });

  int id;
  bool isSelected;
  String firstname;
  String lastname;
  List<String> languages;
  List<String> style;
  String profilePicture;

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json["id"] == null ? null : json["id"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        languages: json["languages"] == null ? [] : List<String>.from(json["languages"].map((x) => x)),
        style: json["style"] == null ? [] : List<String>.from(json["style"].map((x) => x)),
        profilePicture: json["profile_picture"] == null ? null : json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "id":  id,
        "firstname":  firstname,
        "lastname":  lastname,
        "languages":  List<dynamic>.from(languages.map((x) => x)),
        "style":  List<dynamic>.from(style.map((x) => x)),
        "profile_picture": profilePicture ,
      };
}

class Language {
  Language({
    required this.id,
    required this.language,
    this.isSelected = false,
  });
  int id;
  String language;
  bool isSelected;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    language: json["language"] == null ? null : json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language": language,
      };
}

class Level {
  Level({
    required this.id,
    required this.level,
    this.isSelected = false,
  });
  int id;
  String level;
  bool isSelected;

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    id: json["id"],
    level: json["level"] == null ? null : json["level"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "level": level,
      };
}

class Style {
  Style({
    required this.id,
    required this.styleTitle,
    this.isSelected = false,
  });
  int id;
  String styleTitle;
  bool isSelected;

  factory Style.fromJson(Map<String, dynamic> json) => Style(
        id: json["id"],
        styleTitle: json["style_title"] == null ? null : json["style_title"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "style_title": styleTitle,
      };
}
