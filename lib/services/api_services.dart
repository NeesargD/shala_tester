import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shala_yoga/base/utils/config.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/instructor_details_model.dart';
import 'package:shala_yoga/models/instructor_models.dart';
import 'package:shala_yoga/models/onboarding_models.dart';
import 'package:shala_yoga/models/quiz_model.dart';
import 'package:shala_yoga/models/recommendation_model.dart';

class ApiServices {
  static final ApiServices _apiController = ApiServices._internal();
  late Dio _dio;

  static late bool _delay = false;

  factory ApiServices({bool delay = false}) {
    _delay = delay;
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

  Future<Response> _post(String url, Map<String, dynamic> param) async {
    Response response = await _dio.post(
      url,
      data: param,
      // options: Options(headers: {'Cookie': appState.sessionId}),
    );

    /*var session =
    response.headers['set-cookie']?.firstWhereOrNull((element) => (element as String).startsWith('session_id'));
    if (session != null) {
      SaveHeaderSession().saveHeaderSession(session.substring(0, 51));
      appState.sessionId = session.substring(0, 51);
    }*/

    return response;
  }

  Future<Response> _get(String url, Map<String, dynamic> param) async {
    Response response = await _dio.get(
      url,
      queryParameters: param,
    );

    return response;
  }

  ErrorResponse _handleError(DioError error) {
    if (error.type == DioErrorType.other && error.error != null && error.error is SocketException) {}

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
              errorResponse = ErrorResponse(errors: [Error(detail: error.response!.data["error"])]);
            }
          } catch (e) {
            errorResponse = ErrorResponse(errors: [Error(detail: StringRes.errorGeneral)]);
          }
        } else {
          errorResponse = ErrorResponse(errors: [Error(detail: StringRes.errorGeneral)]);
        }

        break;
      case DioErrorType.connectTimeout:
        errorResponse = ErrorResponse(errors: [Error(detail: StringRes.serverTimeout)]);
        break;
      case DioErrorType.receiveTimeout:
        errorResponse = ErrorResponse(errors: [Error(detail: StringRes.serverTimeout)]);
        break;
      case DioErrorType.sendTimeout:
        errorResponse = ErrorResponse(errors: [Error(detail: StringRes.serverTimeout)]);
        break;
      case DioErrorType.other:
        errorResponse = ErrorResponse(errors: [Error(detail: StringRes.somethingWentWrong)]);
        break;
    }
    return errorResponse;
  }

  Future<OnboardingModel> onBoardAPI(/*{required Map<String, dynamic> param}*/) async {
    try {
      Response response = await _dio.get(
        Config.splash,
      );
      print("------");
      return OnboardingModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<QuizModel> quizDetailsApi(/*{required Map<String, dynamic> param}*/) async {
    try {
      Response response = await _dio.get(
        Config.quizDetails,
      );
      print("------");
      return QuizModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<InstructorModel> instructorApi(/*{required Map<String, dynamic> param}*/) async {
    try {
      Response response = await _dio.get(
        Config.instructor,
      );
      print("------");
      return InstructorModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<InstructorDetailsModel> instructorDetailsApi({required Map<String,dynamic>param}) async {
    try {
      Response response = await _dio.get(
        Config.instructorDetails,queryParameters: param
      );
      print("------");
      return InstructorDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<RecommendationModel> recommendedContent(/*{required Map<String,dynamic> param}*/) async {
    try {
      Response response = await _dio.get(
        Config.recommendation,
      );
      print("------");
      return RecommendationModel.fromJson(response.data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  /// put
// Future<AddToCartResponseModel> addToCartApi({Map params}) async {
//   try {
//     Response response = await _dio
//         .put(ApiEndPoint.cart + '/${appState.userId}', data: params);
//     return AddToCartResponseModel.fromJson(response.data);
//   } on DioError catch (e) {
//     throw _handleError(e);
//   }
// }

  ///delete
// Future<ClearCartResponseModel> clearCartApi({Map params}) async {
//   try {
//     Response response = await _dio
//         .delete(ApiEndPoint.cartExt + '/${appState.userId}',data: params);
//     return ClearCartResponseModel.fromJson(response.data);
//   } on DioError catch (e) {
//     throw _handleError(e);
//   }
// }

}
