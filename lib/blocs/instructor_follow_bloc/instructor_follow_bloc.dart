import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/instructor_follow_model.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'instructor_follow_event.dart';

part 'instructor_follow_state.dart';

class InstructorFollowBloc extends Bloc<InstructorFollowEvent, InstructorFollowState> {
  late InstructorFollowModel _instructorFollowModel;

  InstructorFollowBloc() : super(InstructorFollowInitial());

  @override
  Stream<InstructorFollowState> mapEventToState(
    InstructorFollowEvent event,
  ) async* {
    if (event is GetInstructorFollowScreen) {
      try {
        Map<String, dynamic> param = {"user": appState.resLoginModel.id, "instructor": event.instructorID};
        _instructorFollowModel = await ApiServices().instructorFollowApi(param: param);
        if (_instructorFollowModel.success!) {
          yield InstructorFollowSuccess(instructorFollowModel: _instructorFollowModel);
        } else {
          yield InstructorFollowFailure(message: _instructorFollowModel.message!);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield InstructorFollowFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield InstructorFollowFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
