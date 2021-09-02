// To parse this JSON data, do
//
//     final recommendationModel = recommendationModelFromJson(jsonString);

import 'dart:convert';

RecommendationModel recommendationModelFromJson(String str) => RecommendationModel.fromJson(json.decode(str));

String recommendationModelToJson(RecommendationModel data) => json.encode(data.toJson());

class RecommendationModel {
  RecommendationModel({
    this.content,
    required this.success,
    required this.message,
  });

  Content? content;
  bool success;
  String message;

  factory RecommendationModel.fromJson(Map<String, dynamic> json) => RecommendationModel(
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
    required this.recommendedPrograms,
    required this.recommendedClasses,
  });

  List<RecommendedProgram> recommendedPrograms;
  List<RecommendedClass> recommendedClasses;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
      recommendedPrograms: json["recommended_programs"] == null ? [] : List<RecommendedProgram>.from(json["recommended_programs"].map((x) => RecommendedProgram.fromJson(x))),
  recommendedClasses: json["recommended_classes"] == null ? [] : List<RecommendedClass>.from(json["recommended_classes"].map((x) => RecommendedClass.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recommended_programs": recommendedPrograms == null ? null : List<dynamic>.from(recommendedPrograms.map((x) => x.toJson())),
    "recommended_classes": recommendedClasses == null ? null : List<dynamic>.from(recommendedClasses.map((x) => x.toJson())),
  };
}

class RecommendedClass {
  RecommendedClass({
    required this.id,
    required this.instructor,
    required this.title,
    required this.style,
    required this.level,
    required this.language,
    required this.durations,
    required this.videoUrl,
    required this.coverImage,
    required this.isLock,
  });

  int id;
  Instructor? instructor;
  String title;
  List<String> style;
  String level;
  String language;
  String durations;
  String videoUrl;
  String coverImage;
  bool isLock;

  factory RecommendedClass.fromJson(Map<String, dynamic> json) => RecommendedClass(
      id: json["id"] == null ? 0 : json["id"],
      instructor: json["instructor"] == null ? null : Instructor.fromJson
        (json["instructor"]),
      title: json["title"] == null ? '' : json["title"],
      style: json["style"] == null ? [] : List<String>.from(json["style"].map(
      (x) => x)),
  level: json["level"] == null ? '' : json["level"],
  language: json["language"] == null ? '' : json["language"],
  durations: json["durations"] == null ? '' : json["durations"],
  videoUrl: json["video_url"] == null ? '' : json["video_url"],
  coverImage: json["cover_image"] == null ? '' : json["cover_image"],
  isLock: json["is_lock"] == null ? true : json["is_lock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "instructor": instructor,
    "title": title,
    "style": List<dynamic>.from(style.map((x) => x)),
    "level": level ,
    "language": language,
    "durations": durations,
    "video_url": videoUrl,
    "cover_image": coverImage,
    "is_lock": isLock,
  };
}

class Instructor {
  Instructor({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.profilePicture,
  });

  int id;
  String firstname;
  String lastname;
  String profilePicture;

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
    id: json["id"] == null ? 0 : json["id"],
    firstname: json["firstname"] == null ? '': json["firstname"],
    lastname: json["lastname"] == null ? '' : json["lastname"],
    profilePicture: json["profile_picture"] == null ? '' : json["profile_picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "profile_picture": profilePicture,
  };
}

class RecommendedProgram {
  RecommendedProgram({
    required this.id,
    required this.instructor,
    required this.title,
    required this.level,
    required this.style,
    required this.languages,
    required this.count,
    required this.coverImage,
  });

  int id;
  Object? instructor;
  String title;
  List<String> level;
  List<String> style;
  List<String> languages;
  int count;
  String coverImage;

  factory RecommendedProgram.fromJson(Map<String, dynamic> json) => RecommendedProgram(
      id: json["id"] == null ? 0 : json["id"],
      instructor: json["instructor"] == null ? null : Instructor.fromJson(json["instructor"]),
      title: json["title"] == null ? '' : json["title"],
      level: json["level"] == null ? [] : List<String>.from(json["level"].map(
      (x) => x)),
      style: json["style"] == null ? [] : List<String>.from(json["style"].map(
      (x) => x)),
  languages: json["languages"] == null ?[] : List<String>.from
  (json["languages"].map((x) => x)),
  count: json["count"] == null ? '' : json["count"],
  coverImage: json["cover_Image"] == null ? '' : json["cover_Image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "instructor": instructor,
    "title": title,
    "level": List<dynamic>.from(level.map((x) => x)),
    "style": List<dynamic>.from(style.map((x) => x)),
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "count": count,
    "cover_Image": coverImage,
  };
}