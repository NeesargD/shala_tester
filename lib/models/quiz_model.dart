import 'dart:convert';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  QuizModel({
    required this.content,
    required this.success,
    required this.message,
  });

  List<Content> content;
  bool success;
  String message;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    content: json["content"] == null ? [] : List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class Content {
  Content({
    this.questionId,
    this.answers,
  });

  QuestionId? questionId;
  List<Answer>? answers;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    questionId: json["question_id"] == null ? null : QuestionId.fromJson(json["question_id"]),
    answers: json["answers"] == null ? [] : List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId == null ? null : questionId!.toJson(),
    "answers": answers == null ? null : List<dynamic>.from(answers!.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    required this.id,
    required this.answerValue,
    required this.orderBy,
  });

  int id;
  String answerValue;
  int orderBy;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json["id"] == null ? 0 : json["id"],
    answerValue: json["answer_value"] == null ? '' : json["answer_value"],
    orderBy: json["order_by"] == null ? 0 : json["order_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "answer_value": answerValue,
    "order_by": orderBy,
  };
}

class QuestionId {
  QuestionId({
    required this.id,
    required this.questionType,
    required this.questionValue,
    required this.orderBy,
  });

  int id;
  String questionType;
  String questionValue;
  int orderBy;

  factory QuestionId.fromJson(Map<String, dynamic> json) => QuestionId(
    id: json["id"] == null ? 0 : json["id"],
    questionType: json["question_type"] == null ? '' : json["question_type"],
    questionValue: json["question_value"] == null ? '' : json["question_value"],
    orderBy: json["order_by"] == null ? 0 : json["order_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_type": questionType,
    "question_value": questionValue,
    "order_by": orderBy,
  };
}
