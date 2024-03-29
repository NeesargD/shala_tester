import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shala_yoga/base/utils/config.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/auth/res_login.dart';
import 'package:shala_yoga/models/classes/class_details_model.dart';
import 'package:shala_yoga/models/classes/classes_model.dart';
import 'package:shala_yoga/models/common_model.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/faq/faq_model.dart';
import 'package:shala_yoga/models/filter/get_filter.dart';
import 'package:shala_yoga/models/filter/post_filter.dart';
import 'package:shala_yoga/models/home/res_home_model.dart';
import 'package:shala_yoga/models/instructor_details_model.dart';
import 'package:shala_yoga/models/instructor_follow_model.dart';
import 'package:shala_yoga/models/instructor_models.dart';
import 'package:shala_yoga/models/objective/req_objective.dart';
import 'package:shala_yoga/models/objective/res_objective.dart';
import 'package:shala_yoga/models/onboarding_models.dart';
import 'package:shala_yoga/models/programs/program_details_model.dart';
import 'package:shala_yoga/models/programs/programs_model.dart';
import 'package:shala_yoga/models/quiz_model.dart';
import 'package:shala_yoga/models/recommendation_model.dart';

class ApiServices {
  static final ApiServices _apiController = ApiServices._internal();
  late Dio _dio;

  factory ApiServices() {
    _apiController.prepareRequest();
    return _apiController;
  }

  ApiServices._internal();

  void prepareRequest() {
    BaseOptions dioOptions = BaseOptions(
      baseUrl: Config.baseUrl,
      // contentType: 'multipart/form-data',
      responseType: ResponseType.json,
      headers: {
        // 'Content-type':'multipart/form-data'
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  ErrorResponse _handleError(DioError error) {
    if (error.type == DioErrorType.other &&
        error.error != null &&
        error.error is SocketException) {}

    ErrorResponse errorResponse = ErrorResponse();

    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorResponse(
          errors: [Error(detail: StringRes.errorRequestCancelled)],
        );
      case DioErrorType.response:
        if (error.response != null && error.response!.data != null) {
          try {
            if (error.response!.data.length > 1) {
              errorResponse = ErrorResponse.fromJson(error.response!.data);
            } else {
              errorResponse = ErrorResponse(
                  errors: [Error(detail: error.response!.data["error"])]);
            }
          } catch (e) {
            errorResponse =
                ErrorResponse(errors: [Error(detail: StringRes.errorGeneral)]);
          }
        } else {
          errorResponse =
              ErrorResponse(errors: [Error(detail: StringRes.errorGeneral)]);
        }

        break;
      case DioErrorType.connectTimeout:
        errorResponse =
            ErrorResponse(errors: [Error(detail: StringRes.serverTimeout)]);
        break;
      case DioErrorType.receiveTimeout:
        errorResponse =
            ErrorResponse(errors: [Error(detail: StringRes.serverTimeout)]);
        break;
      case DioErrorType.sendTimeout:
        errorResponse =
            ErrorResponse(errors: [Error(detail: StringRes.serverTimeout)]);
        break;
      case DioErrorType.other:
        errorResponse = ErrorResponse(
            errors: [Error(detail: StringRes.somethingWentWrong)]);
        break;
    }
    return errorResponse;
  }

  Future<OnboardingModel> onBoardAPI() async {
    try {
      Response response = await _dio.get(
        Config.splash,
      );
      return OnboardingModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<QuizModel> quizDetailsApi() async {
    try {
      Response response = await _dio.get(
        Config.quizDetails,
      );
      return QuizModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<InstructorModel> getAllInstructors() async {
    try {
      Response response = await _dio.get(
        Config.instructor,
      );
      return InstructorModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<InstructorDetailsModel> instructorDetailsApi(
      {required Map<String, dynamic> param}) async {
    try {
      Response response =
          await _dio.get(Config.instructorDetails, queryParameters: param);
      return InstructorDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<InstructorFollowModel> instructorFollowApi(
      {required Map<String, dynamic> param}) async {
    try {
      Response response = await _dio.post(Config.instructorFollow, data: param);
      return InstructorFollowModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<FaqModel> getFaq() async {
    try {
      Response response = await _dio.get(Config.getFaq);
      return FaqModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map> postQuestionAnswer({required Map<String, dynamic> param}) async {
    try {
      Response response =
          await _dio.post(Config.postQuestionAnswer, data: param);
      return response.data;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<ResObjectiveModel> resObjective({required Map<String, dynamic> param}) async{
    try{
      Response response  = await _dio.post(Config.resObjective, data: param);
      return ResObjectiveModel.fromJson(response.data);
    } on DioError catch(e){
      throw _handleError(e);
    }
}
  Future<ReqObjectiveModel> reqObjective() async{
    try{
      Response response  = await _dio.get(Config.reqObjective);
      return ReqObjectiveModel.fromJson(response.data);
    }on DioError catch(e){
      throw _handleError(e);
    }
  }

  Future<ResLoginModel> postRegistrationDetail(
      {required Map<String, dynamic> param}) async {
    try {
      Response response =
          await _dio.post(Config.postRegistrationDetail, data: param);
      return ResLoginModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<ResLoginModel> postLoginDetail(
      {required Map<String, dynamic> param}) async {
    try {
      Response response = await _dio.post(Config.postLoginDetail, data: param);
      return ResLoginModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<RecommendationModel> recommendedContent() async {
    try {
      Response response = await _dio.get(
        Config.recommendation,
      );
      return RecommendationModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<GetFilterModel> getFilter() async {
    try {
      Response response = await _dio.get(
        Config.getFilter,
      );
      return GetFilterModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<PostFilterModel> postFilter(
      {required Map<String, dynamic> param}) async {
    try {
      Response response = await _dio.post(Config.postFilter, data: param);
      return PostFilterModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<ClassesModel> getAllClasses() async {
    try {
      Response response = await _dio.get(
        Config.getAllClasses,
      );
      return ClassesModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<ClassDetailsModel> getClassDetails(
      {required Map<String, dynamic> param}) async {
    try {
      Response response =
          await _dio.get(Config.getClassDetails, queryParameters: param);
      return ClassDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<ProgramsModel> getAllPrograms() async {
    try {
      Response response = await _dio.get(
        Config.getAllPrograms,
      );
      return ProgramsModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<ProgramDetailModel> getProgramDetail(
      {required Map<String, dynamic> param}) async {
    try {
      Response response =
          await _dio.get(Config.getProgramDetail, queryParameters: param);
      return ProgramDetailModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<HomeModel> getHome() async {
    try {
      Response response = await _dio.get(Config.getHome);
      return HomeModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<CommonModel> addToFavourites(
      {required Map<String, dynamic> param}) async {
    try {
      Response response = await _dio.post(Config.favourites, data: param);
      return CommonModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }
}
