// To parse this JSON data, do
//
//     final instructorDetailsModel = instructorDetailsModelFromJson(jsonString);

import 'dart:convert';

InstructorDetailsModel instructorDetailsModelFromJson(String str) => InstructorDetailsModel.fromJson(json.decode(str));

String instructorDetailsModelToJson(InstructorDetailsModel data) => json.encode(data.toJson());

class InstructorDetailsModel {
  InstructorDetailsModel({
    this.content,
    required this.success,
    required this.message,
  });

  Content? content;
  bool success;
  String message;

  factory InstructorDetailsModel.fromJson(Map<String, dynamic> json) => InstructorDetailsModel(
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
    required this.instructorDetails,
    required this.instructorsPrograms,
    required this.instructorsClasses,
  });

  InstructorDetails instructorDetails;
  List<Programs> instructorsPrograms;
  List<Classes> instructorsClasses;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        instructorDetails: InstructorDetails.fromJson(json["instructor"]),
        instructorsPrograms: List<Programs>.from(json["programs"].map((x) => Programs.fromJson(x))),
        instructorsClasses: List<Classes>.from(json["classes"].map((x) => Classes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "instructor": instructorDetails.toJson(),
        "programs": List<dynamic>.from(instructorsPrograms.map((x) => x.toJson())),
        "classes": List<dynamic>.from(instructorsClasses.map((x) => x.toJson())),
      };
}

class Classes {
  Classes({
    required this.id,
    required this.instructor,
    required this.title,
    required this.focus,
    required this.style,
    required this.level,
    required this.isLock,
    required this.language,
    required this.durations,
    required this.videoUrl,
    required this.coverImage,
  });

  int id;
  ClassInstructor instructor;
  String title;
  List<String> focus;
  List<String> style;
  String level;
  String language;
  bool isLock;
  String durations;
  String videoUrl;
  String coverImage;

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
        id: json["id"],
        instructor: ClassInstructor.fromJson(json["instructor"]),
        title: json["title"],
        focus: List<String>.from(json["focus"].map((x) => x)),
        style: List<String>.from(json["style"].map((x) => x)),
        level: json["level"],
        language: json["language"],
        isLock: json["is_lock"],
        durations: json["durations"],
        videoUrl: json["video_url"],
        coverImage: json["cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instructor": instructor.toJson(),
        "title": title,
        "focus": List<dynamic>.from(focus.map((x) => x)),
        "style": List<dynamic>.from(style.map((x) => x)),
        "level": level,
        "is_lock": isLock,
        "language": language,
        "durations": durations,
        "video_url": videoUrl,
        "cover_image": coverImage,
      };
}

class ClassInstructor {
  ClassInstructor({
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

  factory ClassInstructor.fromJson(Map<String, dynamic> json) => ClassInstructor(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        languages: List<String>.from(json["languages"].map((x) => x)),
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

class InstructorDetails {
  InstructorDetails({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.languages,
    required this.style,
    required this.country,
    required this.state,
    required this.description,
    required this.profilePicture,
    required this.follower,
    required this.program,
    required this.classes,
  });

  int id;
  String firstname;
  String lastname;
  List<String> languages;
  List<String> style;
  String country;
  String state;
  String description;
  String profilePicture;
  int follower;
  int program;
  int classes;

  factory InstructorDetails.fromJson(Map<String, dynamic> json) => InstructorDetails(
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
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "style": List<dynamic>.from(style.map((x) => x)),
        "country": country,
        "state": state,
        "description": description,
        "profile_picture": profilePicture,
        "follower": follower,
        "program": program,
        "classes": classes,
      };
}

class Programs {
  Programs({
    required this.id,
    required this.instructor,
    required this.title,
    required this.style,
    required this.focus,
    required this.level,
    required this.languages,
    required this.count,
    required this.coverImage,
  });

  int id;
  ClassInstructor instructor;
  String title;
  List<String> style;
  List<String> focus;
  String level;
  List<String> languages;
  int count;
  String coverImage;

  factory Programs.fromJson(Map<String, dynamic> json) => Programs(
        id: json["id"],
        instructor: ClassInstructor.fromJson(json["instructor"]),
        title: json["title"],
        style: List<String>.from(json["style"].map((x) => x)),
        focus: List<String>.from(json["focus"].map((x) => x)),
        level: json["level"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        count: json["count"],
        coverImage: json["cover_Image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instructor": instructor.toJson(),
        "title": title,
        "style": List<dynamic>.from(style.map((x) => x)),
        "focus": List<dynamic>.from(focus.map((x) => x)),
        "level": level,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "count": count,
        "cover_Image": coverImage,
      };
}
