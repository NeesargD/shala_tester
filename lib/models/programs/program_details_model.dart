// To parse this JSON data, do
//
//     final programDetailModel = programDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

ProgramDetailModel programDetailModelFromJson(String str) => ProgramDetailModel.fromJson(json.decode(str));

String programDetailModelToJson(ProgramDetailModel data) => json.encode(data.toJson());

class ProgramDetailModel {
  ProgramDetailModel({
    this.content,
    required this.success,
    required this.message,
  });

  Content? content;
  bool success;
  String message;

  factory ProgramDetailModel.fromJson(Map<String, dynamic> json) => ProgramDetailModel(
    content: Content.fromJson(json["content"]),
    success:json["success"],
    message:json["message"],
  );

  Map<String, dynamic> toJson() => {
    "content":content!.toJson(),
    "success": success,
    "message": message,
  };
}

class Content {
  Content({
    required this.programs,
    required this.classes,
  });

  Programs programs;
  List<Class> classes;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    programs:Programs.fromJson(json["programs"]),
    classes: List<Class>.from(json["classes"].map((x) => Class.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "programs":programs.toJson(),
    "classes":List<dynamic>.from(classes.map((x) => x.toJson())),
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
    id: json["id"],
    instructor: Instructor.fromJson(json["instructor"]),
    title: json["title"],
    focus: List<String>.from(json["focus"].map((x) => x)),
    style: List<String>.from(json["style"].map((x) => x)),
    level: json["level"],
    language: json["language"],
    durations: json["durations"],
    videoUrl: json["video_url"],
    coverImage: json["cover_image"],
    isLock: json["is_lock"] == null ? true : json["is_lock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "instructor":instructor.toJson(),
    "title": title,
    "focus":List<dynamic>.from(focus.map((x) => x)),
    "style": List<dynamic>.from(style.map((x) => x)),
    "level": level,
    "language": language,
    "durations": durations,
    "video_url":  videoUrl,
    "cover_image":  coverImage,
    "is_lock": isLock,
  };
}

class Instructor {
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
    id: json["id"],
    firstname: json["firstname"],
    lastname:  json["lastname"],
    languages:  List<String>.from(json["languages"].map((x) => x)),
    style: List<String>.from(json["style"].map((x) => x)),
    profilePicture: json["profile_picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "style": List<dynamic>.from(style.map((x) => x)),
    "profile_picture": profilePicture,
  };
}

class Programs {
  Programs({
    required this.id,
    required this.instructor,
    required this.title,
    required this.description,
    required this.style,
    required this.focus,
    required this.level,
    required this.languages,
    required this.count,
    required this.coverImage,
    required this.teaserVideoUrl,
    required this.weight,
    required this.isFav
  });

  int id;
  Instructor instructor;
  String title;
  String description;
  List<String> style;
  List<String> focus;
  List<String> level;
  List<String> languages;
  int count;
  String coverImage;
  String teaserVideoUrl;
  int weight;
  ValueNotifier<bool> isFav = ValueNotifier<bool>(false);

  factory Programs.fromJson(Map<String, dynamic> json) => Programs(
    id: json["id"],
    instructor: Instructor.fromJson(json["instructor"]),
    title:json["title"],
    description:json["description"],
    style: List<String>.from(json["style"].map((x) => x)),
    focus: List<String>.from(json["focus"].map((x) => x)),
    level:  List<String>.from(json["level"].map((x) => x)),
    languages: List<String>.from(json["languages"].map((x) => x)),
    count: json["count"],
    coverImage: json["cover_Image"],
    teaserVideoUrl:  json["teaser_Video_Url"],
    weight: json["weight"],
    isFav: json["is_fav"] == null ? ValueNotifier<bool>(false) : ValueNotifier<bool>(json["is_fav"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "instructor": instructor.toJson(),
    "title":  title,
    "description": description,
    "style": List<dynamic>.from(style.map((x) => x)),
    "focus":  List<dynamic>.from(focus.map((x) => x)),
    "level": List<dynamic>.from(level.map((x) => x)),
    "languages":  List<dynamic>.from(languages.map((x) => x)),
    "count":count,
    "cover_Image": coverImage,
    "teaser_Video_Url":  teaserVideoUrl,
    "weight": weight,
  };
}
