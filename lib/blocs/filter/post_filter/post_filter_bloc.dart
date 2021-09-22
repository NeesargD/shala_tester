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
  Stream<PostFilterState> mapEventToState(
    PostFilterEvent event,
  ) async* {
    if (event is PostAllFilter) {
      try {
        Map<String, dynamic> param = {
          "start_duration": event.startDuration,
          "end_duration": event.endDuration,
          "style": event.style,
          "language": event.language,
          "level": event.level,
          "focus": event.focus,
          "instructor": event.instructor
        };
        print(param);
        postFilterModel = await ApiServices().postFilter(param: param);
        if (postFilterModel.success) {
          yield PostFilterSuccess(postFilterModel: postFilterModel);
        }
        else {
          yield PostFilterFailure(message: postFilterModel.message);
        }
      } catch (e) {
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
