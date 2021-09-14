// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.content,
    this.success,
    this.message,
  });

  Content? content;
  bool? success;
  String? message;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
    this.banner,
    this.continueWatching,
    this.recommendedContent,
    this.dynamicContent,
    this.featureInstructor,
  });

  List<Banner>? banner;
  ContinueWatching? continueWatching;
  List<RecommendedContent>? recommendedContent;
  List<DynamicContent>? dynamicContent;
  List<Instructor>? featureInstructor;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        banner:
            List<Banner>.from(json["banner"].map((x) => Banner.fromJson(x))),
    continueWatching: json["continue_watching"] == null ? null : ContinueWatching.fromJson(json["continue_watching"]),
    recommendedContent: List<RecommendedContent>.from(json["recommended_content"].map((x) => RecommendedContent.fromJson(x))),
        dynamicContent: List<DynamicContent>.from(
            json["dynamic_content"].map((x) => DynamicContent.fromJson(x))),
        featureInstructor: List<Instructor>.from(
            json["feature_instructor"].map((x) => Instructor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banner": List<dynamic>.from(banner!.map((x) => x.toJson())),
    "continue_watching": continueWatching == null ? null : continueWatching!.toJson(),
        "recommended_content":
            List<dynamic>.from(recommendedContent!.map((x) => x)),
        "dynamic_content":
            List<dynamic>.from(dynamicContent!.map((x) => x.toJson())),
        "feature_instructor":
            List<dynamic>.from(featureInstructor!.map((x) => x.toJson())),
      };
}

class Banner {
  Banner({
    this.bannertype,
    this.programId,
    this.classesId,
    this.instructorId,
    this.externallink,
    this.bannerimage,
  });

  String? bannertype;
  int? programId;
  int? classesId;
  int? instructorId;
  String? externallink;
  String? bannerimage;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        bannertype: json["bannertype"],
        programId: json["program_id"] == null ? null : json["program_id"],
        classesId: json["classes_id"] == null ? null : json["classes_id"],
        instructorId:
            json["instructor_id"] == null ? null : json["instructor_id"],
        externallink: json["externallink"],
        bannerimage: json["bannerimage"],
      );

  Map<String, dynamic> toJson() => {
        "bannertype": bannertype,
        "program_id": programId == null ? null : programId,
        "classes_id": classesId == null ? null : classesId,
        "instructor_id": instructorId == null ? null : instructorId,
        "externallink": externallink,
        "bannerimage": bannerimage,
      };
}

class ContinueWatching {
  ContinueWatching({
    required this.programId,
  });

  List<ProgramsContent> programId;

  factory ContinueWatching.fromJson(Map<String, dynamic> json) => ContinueWatching(
    programId: json["program_id"] == null ? [] : List<ProgramsContent>.from(json["program_id"].map((x) => ProgramsContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "program_id": List<dynamic>.from(programId.map((x) => x.toJson())),
  };
}

class RecommendedContent {
  RecommendedContent({
    required this.contentType,
    this.programs,
    this.classes,
  });

  String contentType;
  ProgramsContent? programs;
  ClassesContent? classes;

  factory RecommendedContent.fromJson(Map<String, dynamic> json) => RecommendedContent(
    contentType: json["content_type"] == null ? '' : json["content_type"],
    programs: json["programs"] == null ? null : ProgramsContent.fromJson(json["programs"]),
    classes: json["classes"] == null ? null : ClassesContent.fromJson(json["classes"]),
  );

  Map<String, dynamic> toJson() => {
    "content_type": contentType,
    "programs": programs == null ? null : programs!.toJson(),
    "classes": classes == null ? null : classes!.toJson(),
  };
}

class DynamicContent {
  DynamicContent({
    this.uitype,
    this.title,
    this.programsContent,
    this.classesContent,
  });

  String? uitype;
  String? title;
  List<ProgramsContent>? programsContent;
  List<ClassesContent>? classesContent;

  factory DynamicContent.fromJson(Map<String, dynamic> json) => DynamicContent(
        uitype: json["uitype"],
        title: json["title"],
        programsContent: List<ProgramsContent>.from(
            json["programs_content"].map((x) => ProgramsContent.fromJson(x))),
        classesContent: List<ClassesContent>.from(
            json["classes_content"].map((x) => ClassesContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uitype": uitype,
        "title": title,
        "programs_content":
            List<dynamic>.from(programsContent!.map((x) => x.toJson())),
        "classes_content":
            List<dynamic>.from(classesContent!.map((x) => x.toJson())),
      };
}

class ClassesContent {
  ClassesContent({
    this.id,
    this.instructor,
    this.title,
    this.focus,
    this.style,
    this.level,
    this.language,
    this.durations,
    this.videoUrl,
    this.coverImage,
    this.isLock,
  });

  int? id;
  Instructor? instructor;
  String? title;
  List<String>? focus;
  List<String>? style;
  String? level;
  String? language;
  String? durations;
  String? videoUrl;
  String? coverImage;
  bool? isLock;

  factory ClassesContent.fromJson(Map<String, dynamic> json) => ClassesContent(
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
    "instructor": instructor!.toJson(),
    "title": title,
    "focus": List<dynamic>.from(focus!.map((x) => x)),
    "style": List<dynamic>.from(style!.map((x) => x)),
    "level": level,
    "language": language,
    "durations": durations,
    "video_url": videoUrl,
    "cover_image": coverImage,
    "is_lock": isLock,
      };
}



class Instructor {
  Instructor({
     this.id,
     this.firstname,
     this.lastname,
     this.languages,
     this.style,
     this.profilePicture,
  });

  int? id;
  String? firstname;
  String? lastname;
  List<String>? languages;
  List<String>? style;
  String? profilePicture;

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
      id: json["id"] == null ?  ''  : json["id"],
      firstname: json["firstname"] == null ?  ''  : json["firstname"],
      lastname: json["lastname"] == null ?  ''  : json["lastname"],
      languages: json["languages"] == null ? [] : List<String>.from(json["languages"].map(
      (x) => x)),
  style: json["style"] == null ? [] : List<String>.from(json["style"].map(
  (x) => x)),
  profilePicture: json["profile_picture"] == null ?  ''  : json["profile_picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "languages":List<String>.from(languages!.map((x)=> x)),
    "style": List<String>.from(style!.map((x) => x)),
    "profile_picture": profilePicture,
  };
}


class ProgramsContent {
  ProgramsContent({
    this.id,
    this.instructor,
    this.title,
    this.style,
    this.focus,
    this.level,
    this.languages,
    this.count,
    this.coverImage,
  });

  int? id;
  Instructor? instructor;
  String? title;
  List<String>? style;
  List<String>? focus;
  List<String>? level;
  List<String>? languages;
  int? count;
  String? coverImage;

  factory ProgramsContent.fromJson(Map<String, dynamic> json) =>
      ProgramsContent(
        id: json["id"],
        instructor: Instructor.fromJson(json["instructor"]),
        title: json["title"],
          style: json["style"] == null ? [] : List<String>.from(json["style"].map((x) => x)),
  focus: json["focus"] == null ? [] : List<String>.from(json["focus"].map((x) => x)),
  level: json["level"] == null ? [] : List<String>.from(json["level"].map((x) => x)),
  languages: json["languages"] == null ? [] : List<String>.from(json["languages"].map((x) => x)),
        count: json["count"],
        coverImage: json["cover_Image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instructor": instructor!.toJson(),
        "title": title,
    "style": List<dynamic>.from(style!.map((x) => x)),
    "focus": List<dynamic>.from(focus!.map((x) => x)),
    "level": List<dynamic>.from(level!.map((x) => x)),
    "languages": List<dynamic>.from(languages!.map((x) => x)),
        "count": count,
        "cover_Image": coverImage,
      };
}


