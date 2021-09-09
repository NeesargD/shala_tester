import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/models/error_response.dart';
import 'package:shala_yoga/models/faq/faq_model.dart';
import 'package:shala_yoga/services/api_services.dart';

part 'faq_event.dart';

part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  late FaqModel _faqModel;

  FaqBloc() : super(FaqInitial());

  @override
  Stream<FaqState> mapEventToState(
    FaqEvent event,
  ) async* {
    if (event is GetAllFaq) {
      try {
        _faqModel = await ApiServices().getFaq();
        if (_faqModel.message != null) {
          yield FaqSuccess(faqModel: _faqModel);
        } else {
          yield FaqFailure(message: _faqModel.message!);
        }
      } catch (e) {
        print(e.toString());
        try {
          ErrorResponse? errorResponse = e as ErrorResponse?;
          yield FaqFailure(message: errorResponse!.errors![0].detail!);
        } catch (e) {
          yield FaqFailure(message: StringRes.somethingWentWrong);
        }
      }
    }
  }
}
