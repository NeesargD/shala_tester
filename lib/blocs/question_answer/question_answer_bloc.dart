import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/question_answer/question_answer_model.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'question_answer_event.dart';

part 'question_answer_state.dart';

class QuestionAnswerBloc
    extends Bloc<QuestionAnswerEvent, QuestionAnswerState> {
  QuestionAnswerBloc() : super(QuestionAnswerInitial());

  @override
  Stream<QuestionAnswerState> mapEventToState(
    QuestionAnswerEvent event,
  ) async* {
    if (event is SubmitQuestionAnswer) {
      try {
        SubmittedAnswerModel submitQuestionAnswer = SubmittedAnswerModel(
            submittedAnswer: event.submittedAnswers, deviceId: '123');
        Map<String, dynamic> param = submitQuestionAnswer.toJson();

        print(param);
        var response = await ApiServices().postQuestionAnswer(param: param);
        if (response['success'] == true) {
          yield QuestionAnswerSuccess(message: 'Quiz Submitted Successfully');
        } else {
          yield QuestionAnswerFailure(message: StringRes.somethingWentWrong);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield QuestionAnswerFailure(
              message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield QuestionAnswerFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
