import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/base/utils/preference_utils.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/image_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../base/utils/navigation/navigation_route_constants.dart';
import '../../base/utils/navigation/navigation_utils.dart';
import '../../blocs/question_answer/question_answer_bloc.dart';
import '../../models/question_answer/question_answer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreatheLoader extends StatefulWidget {
  final List<SubmittedAnswer>? questionAnswerList;

  BreatheLoader({this.questionAnswerList});

  @override
  _BreatheLoaderState createState() => _BreatheLoaderState();
}

class _BreatheLoaderState extends State<BreatheLoader> {
  @override
  void initState() {
    context.read<QuestionAnswerBloc>()
      ..add(SubmitQuestionAnswer(submittedAnswers: widget.questionAnswerList!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorRes.greyText,
        body: BlocListener<QuestionAnswerBloc, QuestionAnswerState>(
          listener: (context, state) {
            if (state is QuestionAnswerSuccess) {
              setBool("quizSubmitted", true);
              NavigationUtils.pushAndRemoveUntil(context, routeDashboard,
                  arguments: {"index": 5});
            }
            if (state is QuestionAnswerFailure) {}
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageRes.take_a_breath,
                  height: 50,
                  width: 50,
                  color: ColorRes.white,
                ),
                SizedBox(height: 30),
                Text(AppLocalizations.of(context)!.translate("take_a_breath"), style: TextStyles.L25FF),
                Text(AppLocalizations.of(context)!.translate("we_are_tailoring_your_classes"), style: TextStyles.L15FF),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
