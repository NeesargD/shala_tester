import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/auth/res_login.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is GetLoginDetails){
      yield LoginLoading();
      try {
        Map<String, dynamic> param;
        param = {
          "device_id": appState.deviceId,
          "fcm_token": "12345",
          "username": event.username,
          "password": event.password
        };
        print(param);
        var response = await ApiServices().postLoginDetail(param: param);
          if (response.success) {
            yield LoginSuccess(message: response.message);
          }
          else {
            yield LoginFailure(message: response.message);
          }

      }
      catch (e){
        print(e.toString());
        try{
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield LoginFailure(message: errorResponse!.errors![0].detail!);
        }catch(e){
          yield LoginFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
