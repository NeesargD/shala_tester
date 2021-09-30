import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/objective/res_objective.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'res_objective_event.dart';
part 'res_objective_state.dart';

class ResObjectiveBloc extends Bloc<ResObjectiveEvent, ResObjectiveState> {
  late ResObjectiveModel _resObjectiveModel;
  ResObjectiveBloc() : super(ResObjectiveInitial());

  @override
  Stream<ResObjectiveState> mapEventToState(
    ResObjectiveEvent event,
  ) async* {
    if(event is ResObjective){
      try{
        Map<String, dynamic> param = {"user": appState.userId, "objective" : event.objectiveId};
        _resObjectiveModel = await ApiServices().resObjective(param: param);
        if(_resObjectiveModel.success){
        yield ResObjectiveSuccess(resObjectiveModel: _resObjectiveModel);
        }
        else{
          yield ResObjectiveFailure(message: _resObjectiveModel.message);
        }
      }catch (e){
        print(e.toString());
        try{
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield ResObjectiveFailure(message: errorResponse!.errors![0].detail!);
        }
        catch(e){
          yield ResObjectiveFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
