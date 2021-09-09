// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    this.content,
    this.contact,
    this.success,
    this.message,
  });

  List<Content>? content;
  Contact? contact;
  bool? success;
  String? message;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    contact: Contact.fromJson(json["contact"]),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content!.map((x) => x.toJson())),
    "contact": contact!.toJson(),
    "success": success,
    "message": message,
  };
}

class Contact {
  Contact({
    this.supportcontact,
    this.whatsappcontact,
  });

  String? supportcontact;
  String? whatsappcontact;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    supportcontact: json["supportcontact"],
    whatsappcontact: json["whatsappcontact"],
  );

  Map<String, dynamic> toJson() => {
    "supportcontact": supportcontact,
    "whatsappcontact": whatsappcontact,
  };
}

class Content {
  Content({
    this.title,
    this.questionAnswer,
  });

  String? title;
  List<QuestionAnswer>? questionAnswer;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    title: json["title"],
    questionAnswer: List<QuestionAnswer>.from(json["question_answer"].map((x) => QuestionAnswer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "question_answer": List<dynamic>.from(questionAnswer!.map((x) => x.toJson())),
  };
}

class QuestionAnswer {
  QuestionAnswer({
    this.question,
    this.answer,
  });

  String? question;
  String? answer;

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
  };
}
