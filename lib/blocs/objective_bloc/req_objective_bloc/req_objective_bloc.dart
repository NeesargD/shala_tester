import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/objective/req_objective.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'req_objective_event.dart';

part 'req_objective_state.dart';

class ReqObjectiveBloc extends Bloc<ReqObjectiveEvent, ReqObjectiveState> {
  late ReqObjectiveModel _reqObjectiveModel;

  ReqObjectiveBloc() : super(ReqObjectiveInitial());

  @override
  Stream<ReqObjectiveState> mapEventToState(
    ReqObjectiveEvent event,
  ) async* {
    if (event is ReqObjectiveEvent) {
      try {
        _reqObjectiveModel = await ApiServices().reqObjective();
        if (_reqObjectiveModel.success) {
          yield ReqObjectiveSuccess(reqObjectiveModel: _reqObjectiveModel);
        } else {
          yield ReqObjectiveFailure(message: _reqObjectiveModel.message);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield ReqObjectiveFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield ReqObjectiveFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
