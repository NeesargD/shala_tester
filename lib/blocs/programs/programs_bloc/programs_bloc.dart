import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/programs/programs_model.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'programs_event.dart';
part 'programs_state.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  late ProgramsModel _programsModel;
  ProgramsBloc() : super(ProgramsInitial());

  @override
  Stream<ProgramsState> mapEventToState(
    ProgramsEvent event,
  ) async* {
    if (event is GetAllPrograms) {
      try {
        _programsModel = await ApiServices().getAllPrograms();
        if (_programsModel.success) {
          if (_programsModel.content!.programs.length != 0) {
            yield ProgramsSuccess(programsModel: _programsModel);
          } else {
            yield ProgramsFailure(message: _programsModel.message);
          }
        } else {
          yield ProgramsFailure(message: _programsModel.message);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield ProgramsFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield ProgramsFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
