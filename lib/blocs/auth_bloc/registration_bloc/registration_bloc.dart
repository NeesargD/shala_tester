import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/auth/res_register.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/services/api_services.dart';
part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {

  ResRegistrationModel? registrationModel;
  RegistrationBloc() : super(RegistrationInitial());

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if(event is GetRegistrationDetails){
      yield RegistrationLoading();
      try{
      Map<String,dynamic> param = {
        "device_id": appState.deviceId,
        "fcm_token":"12345",
        "name": event.name,
        "email": event.email,
        "password":event.password,
        "phone_number":event.phoneNumber == '' ? null: event.phoneNumber
      };
        print(param);
        var response = await ApiServices().postRegistrationDetail(param: param);
        if (response.success) {
          yield RegistrationSuccess(message: response.message);
        }
        else {
          yield RegistrationFailure(message: response.message);
        }

      }
      catch(e){
        print(e.toString());
        try{
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield RegistrationFailure(message: errorResponse!.errors![0].detail!);
        }
        catch(e){
          yield RegistrationFailure(message: StringRes.somethingWentWrong);
        }
        }
    }
  }
}
