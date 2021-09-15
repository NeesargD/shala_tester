import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/common_model.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'favourite_event.dart';

part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  late CommonModel _commonModel;

  FavouriteBloc() : super(FavouriteInitial());

  @override
  Stream<FavouriteState> mapEventToState(
    FavouriteEvent event,
  ) async* {
    if (event is AddToFavourite) {
      try {
        yield FavouriteLoading();
        //TODO: Make user id dynamic
        Map<String, dynamic> param = {"user_id": 1, "program_id": event.programId, "class_id": event.classId, "content_type": event.contentType};

        print(param);

        _commonModel = await ApiServices().addToFavourites(param: param);
        if (_commonModel.success) {
          yield FavouriteSuccess(message: _commonModel.message);
        } else {
          yield FavouriteFailure(message: _commonModel.message);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield FavouriteFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield FavouriteFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
