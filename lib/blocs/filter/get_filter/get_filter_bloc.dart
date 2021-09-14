import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/filter/get_filter.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'get_filter_event.dart';

part 'get_filter_state.dart';

class GetFilterBloc extends Bloc<GetFilterEvent, GetFilterState> {
  late GetFilterModel _getFilterModel;

  GetFilterBloc() : super(GetFilterInitial());

  @override
  Stream<GetFilterState> mapEventToState(
    GetFilterEvent event,
  ) async* {
    if (event is GetAllFilter) {
      try {
        _getFilterModel = await ApiServices().getFilter();
        if (_getFilterModel.success) {
          yield GetFilterSuccess(getFilterModel: _getFilterModel);
        } else {
          yield GetFilterFailure(message: _getFilterModel.message);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield GetFilterFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield GetFilterFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
