class SubmittedAnswerModel {
  SubmittedAnswerModel({
    this.deviceId,
    this.submittedAnswer,
  });

  String? deviceId;
  List<SubmittedAnswer>? submittedAnswer;

  factory SubmittedAnswerModel.fromJson(Map<String, dynamic> json) => SubmittedAnswerModel(
    deviceId: json["device_id"],
    submittedAnswer: List<SubmittedAnswer>.from(json["submitted_answers"].map((x) => SubmittedAnswer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "submitted_answers": List<dynamic>.from(submittedAnswer!.map((x) => x
        .toJson())),
  };
}

class SubmittedAnswer {
  SubmittedAnswer({
    this.questionId,
    this.answer,
  });

  int? questionId;
  List<String>? answer;

  factory SubmittedAnswer.fromJson(Map<String, dynamic> json) => SubmittedAnswer(
    questionId: json["question_id"],
    answer: List<String>.from(json["answers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "answers": List<dynamic>.from(answer!.map((x) => x)),
  };
}