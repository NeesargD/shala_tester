import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/utils/constants/string_res.dart';
import '../../models/error_response.dart';
import '../../models/recommendation_model.dart';
import '../../services/api_services.dart';

part 'recommendation_event.dart';

part 'recommendation_state.dart';

class RecommendationBloc extends Bloc<RecommendationEvent, RecommendationState> {
  late RecommendationModel _recommendationModel;

  RecommendationBloc() : super(RecommendationInitial());

  @override
  Stream<RecommendationState> mapEventToState(RecommendationEvent event) async* {
    if (event is GetRecommendationContent) {
      try {
        _recommendationModel = await ApiServices().recommendedContent();
        if (_recommendationModel.success) {
          yield RecommendationSuccess(recommendationModel: _recommendationModel);
        } else {
          yield RecommendationFailure(message: _recommendationModel.message);
        }
      }
      catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield RecommendationFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield RecommendationFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
