import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/programs/program_details_model.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'program_detail_event.dart';
part 'program_detail_state.dart';

class ProgramDetailBloc extends Bloc<ProgramDetailEvent, ProgramDetailState> {
  late ProgramDetailModel _programDetailModel;
  ProgramDetailBloc() : super(ProgramDetailInitial());
  @override
  Stream<ProgramDetailState> mapEventToState(
    ProgramDetailEvent event,
  ) async* {
    if(event is GetProgramDetail){
      try{
        Map<String,dynamic> param  = {
          'id' : event.id
        };
        _programDetailModel = await ApiServices().getProgramDetail(param:
        param);
        if (_programDetailModel.success) {
          yield ProgramDetailSuccess(programDetailModel: _programDetailModel);
        } else {
          yield ProgramDetailFailure(message: _programDetailModel.message);
        }
      }
      catch(e){
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield ProgramDetailFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield ProgramDetailFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
