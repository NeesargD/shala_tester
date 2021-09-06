import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/home/res_home_model.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late HomeModel _homeModel;

  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetAllHomes) {
      try {
        _homeModel = await ApiServices().getHome();
        if (_homeModel.success!) {
          yield HomeSuccess(homeModel: _homeModel);
        } else {
          yield HomeFailure(message: _homeModel.message!);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield HomeFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield HomeFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
