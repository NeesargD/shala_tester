import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/instructor_details_model.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'instructor_details_event.dart';

part 'instructor_details_state.dart';

class InstructorDetailsBloc extends Bloc<InstructorDetailsEvent, InstructorDetailsState> {
  late InstructorDetailsModel _instructorDetailsModel;

  InstructorDetailsBloc() : super(InstructorDetailsInitial());

  @override
  Stream<InstructorDetailsState> mapEventToState(
    InstructorDetailsEvent event,
  ) async* {
    if (event is GetInstructorDetailsScreen) {
      try {

        Map<String,dynamic> param  = {
          'id' : event.id
        };
        _instructorDetailsModel = await ApiServices().instructorDetailsApi(param: param);
        if (_instructorDetailsModel.success) {
          yield InstructorDetailsSuccess(instructorDetailsModel: _instructorDetailsModel);
        } else {
          yield InstructorDetailsFailure(message: _instructorDetailsModel.message);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield InstructorDetailsFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield InstructorDetailsFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
