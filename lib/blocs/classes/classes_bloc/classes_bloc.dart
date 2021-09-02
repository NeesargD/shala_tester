import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/classes/classes_model.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'classes_event.dart';

part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  late ClassesModel _classesModel;

  ClassesBloc() : super(ClassesInitial());

  @override
  Stream<ClassesState> mapEventToState(
    ClassesEvent event,
  ) async* {
    if (event is GetAllClasses) {
      try {
        _classesModel = await ApiServices().getAllClasses();
        if (_classesModel.success) {
          if (_classesModel.content!.classes.length != 0) {
            yield ClassesSuccess(classesModel: _classesModel);
          } else {
            yield ClassesFailure(message: _classesModel.message);
          }
        } else {
          yield ClassesFailure(message: _classesModel.message);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield ClassesFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield ClassesFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
