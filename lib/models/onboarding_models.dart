import 'dart:convert';

OnboardingModel onboardingModelFromJson(String str) => OnboardingModel.fromJson(json.decode(str));

String onboardingModelToJson(OnboardingModel data) => json.encode(data.toJson());

class OnboardingModel {
  OnboardingModel({
    this.content,
    required this.success,
    required this.message,
  });

  Content? content;
  bool success;
  String message;

  factory OnboardingModel.fromJson(Map<String, dynamic> json) => OnboardingModel(
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
    required this.page,
  });

  List<Page> page;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        page: json["pages"] == null ? [] : List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pages": List<dynamic>.from(page.map((x) => x.toJson())),
      };
}

class Page {
  Page({
    required this.splashTitle,
    required this.image,
    required this.splashText,
  });

  String splashTitle;
  String image;
  String splashText;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        splashTitle: json["splashTitle"] == null ? '' : json["splashTitle"],
        image: json["image"] == null ? '' : json["image"],
        splashText: json["splashText"] == null ? '' : json["splashText"],
      );

  Map<String, dynamic> toJson() => {
        "splashTitle": splashTitle,
        "image": image,
        "splashText": splashText,
      };
}
