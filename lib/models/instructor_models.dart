import 'dart:convert';

InstructorModel instructorModelFromJson(String str) => InstructorModel.fromJson(json.decode(str));

String instructorModelToJson(InstructorModel data) => json.encode(data.toJson());

class InstructorModel {
  InstructorModel({
    this.content,
    required this.success,
    required this.message,
  });

  Content? content;
  bool success;
  String message;

  factory InstructorModel.fromJson(Map<String, dynamic> json) => InstructorModel(
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
    required this.instructors,
  });

  List<Instructor> instructors;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    instructors: json["instructors"] == null ? [] :
    List<Instructor>.from(json["instructors"].map((x) => Instructor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "instructors": List<dynamic>.from(instructors.map((x) => x.toJson())),
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
    "languages":List<String>.from(languages.map((x)=> x)),
    "style": List<String>.from(style.map((x) => x)),
    "profile_picture": profilePicture,
  };
}
