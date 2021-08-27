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
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "content": content == null ? null : content!.toJson(),
        "success": success,
        "message": message,
      };
}

class Content {
  Content({
    this.instructor,
    required this.programs,
    required this.classes,
  });

  Instructor? instructor;
  List<Program> programs;
  List<Classes> classes;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        instructor: json["instructor"] == null ? null : Instructor.fromJson(json["instructor"]),
        programs: json["programs"] == null ? [] : List<Program>.from(json["programs"].map((x) => Program.fromJson(x))),
        classes: json["classes"] == null ? [] : List<Classes>.from(json["classes"].map((x) => Classes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "instructor": instructor == null ? null : instructor!.toJson(),
        "programs": List<dynamic>.from(programs.map((x) => x.toJson())),
        "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
      };
}

class Classes {
  Classes({
    required this.id,
    required this.instructorId,
    required this.programIdId,
    required this.title,
    required this.durations,
    required this.level,
    required this.languageId,
    required this.videoUrl,
    required this.isLock,
    required this.weight,
    required this.coverImage,
  });

  int id;
  int instructorId;
  int programIdId;
  String title;
  String durations;
  String level;
  int languageId;
  String videoUrl;
  bool isLock;
  int weight;
  String coverImage;

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
        id: json["id"] == null ? null : json["id"],
        instructorId: json["instructor_id"] == null ? null : json["instructor_id"],
        programIdId: json["program_id_id"] == null ? null : json["program_id_id"],
        title: json["title"] == null ? '' : json["title"],
        durations: json["durations"] == null ? 0.toString() : json["durations"],
        level: json["level"] == null ? '' : json["level"],
        languageId: json["language_id"] == null ? null : json["language_id"],
        videoUrl: json["video_url"] == null ? null : json["video_url"],
        isLock: json["is_lock"] == null ? true : json["is_lock"],
        weight: json["weight"] == null ? null : json["weight"],
        coverImage: json["cover_image"] == null ? null : json["cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instructor_id": instructorId,
        "program_id_id": programIdId,
        "title": title,
        "durations": durations,
        "level": level,
        "language_id": languageId,
        "video_url": videoUrl,
        "is_lock": isLock,
        "weight": weight,
        "cover_image": coverImage,
      };
}

class Instructor {
  Instructor({
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

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json["id"] == null ? null : json["id"],
        firstname: json["firstname"] == null ? '' : json["firstname"],
        lastname: json["lastname"] == null ? '' : json["lastname"],
        languages: json["languages"] == null ? [] : List<String>.from(json["languages"].map((x) => x)),
        style: json["style"] == null ? [] : List<String>.from(json["style"].map((x) => x)),
        country: json["country"] == null ? '' : json["country"],
        state: json["state"] == null ? '' : json["state"],
        description: json["description"] == null ? '' : json["description"],
        profilePicture: json["profile_picture"] == null ? '' : json["profile_picture"],
        follower: json["follwer"] == null ? 0 : json["follwer"],
        program: json["program"] == null ? 0 : json["program"],
        classes: json["classes"] == null ? 0 : json["classes"],
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
        "follwer": follower,
        "program": program,
        "classes": classes,
      };
}

class Program {
  Program({
    required this.id,
    required this.instructorId,
    required this.title,
    required this.teaserVideoUrl,
    required this.level,
    required this.description,
    required this.count,
    required this.coverImage,
    required this.weight,
  });

  int id;
  int instructorId;
  String title;
  String teaserVideoUrl;
  String level;
  String description;
  int count;
  String coverImage;
  int weight;

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        id: json["id"] == null ? null : json["id"],
        instructorId: json["instructor_id"] == null ? null : json["instructor_id"],
        title: json["title"] == null ? null : json["title"],
        teaserVideoUrl: json["teaser_Video_Url"] == null ? null : json["teaser_Video_Url"],
        level: json["level"] == null ? null : json["level"],
        description: json["description"] == null ? null : json["description"],
        count: json["count"] == null ? null : json["count"],
        coverImage: json["cover_Image"] == null ? null : json["cover_Image"],
        weight: json["weight"] == null ? null : json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instructor_id": instructorId,
        "title": title,
        "teaser_Video_Url": teaserVideoUrl,
        "level": level,
        "description": description,
        "count": count,
        "cover_Image": coverImage,
        "weight": weight,
      };
}
