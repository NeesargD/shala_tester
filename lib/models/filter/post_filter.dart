import '../instructor_details_model.dart';

class PostFilterModel {
  PostFilterModel({
    this.content,
    required this.success,
    required this.message,
  });

  Content? content;
  bool success;
  String message;

  factory PostFilterModel.fromJson(Map<String, dynamic> json) => PostFilterModel(
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

class Content{
  Content({
    required this.programs,
    required this.classes,
  });

  List<Programs> programs;
  List<Classes> classes;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    programs: List<Programs>.from(json["programs"].map((x) => Programs.fromJson(x))),
    classes: List<Classes>.from(json["classes"].map((x) => Classes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "programs": List<dynamic>.from(programs.map((x) => x.toJson())),
    "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
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
