import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../base/utils/constants/string_res.dart';
import '../../../models/error_response.dart';
import '../../../models/filter/post_filter.dart';
import '../../../services/api_services.dart';

part 'post_filter_event.dart';
part 'post_filter_state.dart';

class PostFilterBloc extends Bloc<PostFilterEvent, PostFilterState> {
  PostFilterBloc() : super(PostFilterInitial());

  late PostFilterModel postFilterModel;

  @override
  Stream<PostFilterState> mapEventToState(PostFilterEvent event,) async* {
    if (event is PostAllFilter) {
      yield PostFilterLoading();
      try {
        Map<String, dynamic> param = {
          "startDuration": event.startDuration,
          "endDuration": event.endDuration,
          "style": event.style,
          "language": event.language,
          "level": event.level,
          "focus": event.focus,
          "instructor": event.instructor
        };
        print(param);
        var response = await ApiServices().postFilter(param: param);
        if (response.success) {
          yield PostFilterSuccess(message: response.message);
        }
        else {
          yield PostFilterFailure(message: response.message);
        }
      }
      catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield PostFilterFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield PostFilterFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
