// To parse this JSON data, do
//
//     final classDetailsModel = classDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../instructor_models.dart';
import '../instructor_details_model.dart' as InstructorDetails;

ClassDetailsModel classDetailsModelFromJson(String str) =>
    ClassDetailsModel.fromJson(json.decode(str));

String classDetailsModelToJson(ClassDetailsModel data) => json.encode(data.toJson());

class ClassDetailsModel {
  ClassDetailsModel({
    this.content,
    required this.success,
    required this.message,
  });

  Content? content;
  bool success;
  String message;

  factory ClassDetailsModel.fromJson(Map<String, dynamic> json) => ClassDetailsModel(
        content: Content.fromJson(json["content"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "content": content!.toJson(),
        "success": success,
        "message": message,
      };
}

class Content {
  Content({
    required this.classes,
    required this.similarClasses,
  });

  Classes classes;
  List<InstructorDetails.Classes> similarClasses;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        classes: Classes.fromJson(json["classes"]),
        similarClasses: List<InstructorDetails.Classes>.from(
            json["similarclasses"].map((x) => InstructorDetails.Classes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "classes": classes.toJson(),
        "similarclasses": List<dynamic>.from(similarClasses.map((x) => x.toJson())),
      };
}

class Classes {
  Classes(
      {required this.id,
      required this.instructor,
      required this.title,
      required this.partOf,
      required this.description,
      required this.focus,
      required this.style,
      required this.level,
      required this.language,
      required this.durations,
      required this.videoUrl,
      required this.coverImage,
      required this.isLock,
      required this.isFav});

  int id;
  Instructor instructor;
  String title;
  String partOf;
  String description;
  List<String> focus;
  List<String> style;
  String level;
  String language;
  String durations;
  String videoUrl;
  String coverImage;
  bool isLock;
  ValueNotifier<bool> isFav = ValueNotifier<bool>(false);

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
        id: json["id"],
        instructor: Instructor.fromJson(json["instructor"]),
        title: json["title"],
        partOf: json["partof"] == null ? '' : json["partof"],
        description: json["description"] == null ? '' : json["description"],
        focus: List<String>.from(json["focus"].map((x) => x)),
        style: List<String>.from(json["style"].map((x) => x)),
        level: json["level"],
        language: json["language"],
        durations: json["durations"],
        videoUrl: json["video_url"],
        coverImage: json["cover_image"],
        isLock: json["is_lock"] == null ? true : json["is_lock"],
        isFav: json["is_fav"] == null ? ValueNotifier<bool>(false) : ValueNotifier<bool>(json["is_fav"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instructor": instructor.toJson(),
        "title": title,
        "is_fav": isFav,
        "partof": partOf,
        "description": description,
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

/*class SimilarClass {
  SimilarClass({
    required this.classes,
    required this.level,
    required this.style,
    required this.focus,
  });

  Classes classes;
  String level;
  List<String> style;
  List<String> focus;

  factory SimilarClass.fromJson(Map<String, dynamic> json) => SimilarClass(
        classes: Classes.fromJson(json["classes"]),
        level: json["level"],
        style: List<String>.from(json["style"].map((x) => x)),
        focus: List<String>.from(json["focus"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "classes": classes.toJson(),
        "level": level,
        "style": List<dynamic>.from(style.map((x) => x)),
        "focus": List<dynamic>.from(focus.map((x) => x)),
      };
}*/
