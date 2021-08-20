import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../base/utils/constants/string_res.dart';
import '../../models/error_response.dart';
import '../../models/onboarding_models.dart';
import '../../services/api_services.dart';

part 'intro_event.dart';

part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  late OnboardingModel _onboardingModel;

  IntroBloc() : super(IntroInitial());

  @override
  Stream<IntroState> mapEventToState(
    IntroEvent event,
  ) async* {
    if (event is GetIntroScreens) {
      try {
        _onboardingModel = await ApiServices().onBoardAPI();
        if (_onboardingModel.success) {
          if (_onboardingModel.content!.page.length != 0) {
            yield IntroSuccess(onboardingModel: _onboardingModel);
          } else {
            yield IntroFailure(message: _onboardingModel.message);
          }
        } else {
          yield IntroFailure(message: _onboardingModel.message);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield IntroFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield IntroFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
