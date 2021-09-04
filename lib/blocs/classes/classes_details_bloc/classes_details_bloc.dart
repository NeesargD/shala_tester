
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/classes/class_details_model.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'classes_details_event.dart';
part 'classes_details_state.dart';

class ClassesDetailsBloc extends Bloc<ClassesDetailsEvent, ClassesDetailsState> {
  late ClassDetailsModel _classDetailsModel;
  ClassesDetailsBloc() : super(ClassesDetailsInitial());

  @override
  Stream<ClassesDetailsState> mapEventToState(
    ClassesDetailsEvent event,
  ) async* {
    if (event is GetClassDetails) {
      try {

        Map<String,dynamic> param  = {
          'id' : event.id
        };
        _classDetailsModel = await ApiServices().getClassDetails(param: param);
        if (_classDetailsModel.success) {
          yield ClassDetailsSuccess(classDetailsModel: _classDetailsModel);
        } else {
          yield ClassDetailsFailure(message: _classDetailsModel.message);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield ClassDetailsFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield ClassDetailsFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
