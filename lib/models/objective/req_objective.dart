class ReqObjectiveModel {
  ReqObjectiveModel({
    this.content,
    required this.success,
    required this.message,
  });

  List<Content>? content;
  bool success;
  String message;

  factory ReqObjectiveModel.fromJson(Map<String, dynamic> json) => ReqObjectiveModel(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content!.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class Content {
  Content({
    required this.id,
    required this.objectiveName,
  });

  int id;
  String objectiveName;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["id"],
    objectiveName: json["objective_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "objective_name": objectiveName,
  };
}
