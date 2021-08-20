import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/quiz_model.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'quiz_details_event.dart';

part 'quiz_details_state.dart';

class QuizDetailsBloc extends Bloc<QuizDetailsEvent, QuizDetailsState> {
  late QuizModel _quizModel;

  QuizDetailsBloc() : super(QuizDetailsInitial());

  @override
  Stream<QuizDetailsState> mapEventToState(
    QuizDetailsEvent event,
  ) async* {
    if (event is GetQuizDetails) {
      try {
        _quizModel = await ApiServices().quizDetailsApi();
        if (_quizModel.success) {
          if (_quizModel.content.isNotEmpty) {
            _quizModel.content.sort((a, b) => a.questionId!.orderBy.compareTo(b.questionId!.orderBy));
            _quizModel.content.forEach((element) {
              element.answers!.sort((a, b) => a.orderBy.compareTo(b.orderBy));
            });
            print(_quizModel);
            yield QuizDetailsSuccess(quizModel: _quizModel);
          } else {
            yield QuizDetailsFailure(message: _quizModel.message);
          }
        } else {
          yield QuizDetailsFailure(message: _quizModel.message);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield QuizDetailsFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield QuizDetailsFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
