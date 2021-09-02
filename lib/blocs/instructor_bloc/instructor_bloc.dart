import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/instructor_models.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'instructor_event.dart';
part 'instructor_state.dart';

class InstructorBloc extends Bloc<InstructorEvent,InstructorState>{
  late InstructorModel _instructorModel;

  InstructorBloc(): super(InstructorInitial());

  @override
  Stream<InstructorState> mapEventToState(InstructorEvent event) async* {
    if (event is GetInstructorScreen){
      try{

        _instructorModel = await ApiServices().getAllInstructors();
        if(_instructorModel.success){
          if(_instructorModel.content!.instructors.length != 0){
            yield InstructorSuccess(instructorModel: _instructorModel);
          }
          else{
            yield InstructorFailure(message: _instructorModel.message);
          }
        }
        else{
          yield InstructorFailure(message: _instructorModel.message);
        }
      }
      catch(e){
        print(e.toString());
        try{
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield InstructorFailure(message:  errorResponse!.errors![0].detail!);
        }
        catch(e){
          yield InstructorFailure(message: StringRes.somethingWentWrong);
        }
        }
        }
      }
}