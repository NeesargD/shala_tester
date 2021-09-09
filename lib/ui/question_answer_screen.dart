import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/models/question_answer/question_answer_model.dart';
import 'package:shala_yoga/models/quiz_model.dart';

import '../base/utils/common_methods.dart';
import '../base/utils/constants/color_constant.dart';
import '../base/utils/constants/textstyle_constants.dart';
import '../base/utils/navigation/navigation_route_constants.dart';
import '../base/utils/navigation/navigation_utils.dart';
import '../blocs/quiz_details_bloc/quiz_details_bloc.dart';
import 'widgets/custom_button.dart';
import 'widgets/failure_widget.dart';
import 'widgets/loading_widget.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({Key? key}) : super(key: key);

  @override
  _QuestionAnswerScreenState createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  PageController _pageController = PageController();
  int initialPage = 0;
  bool isSelected = false;
  List<SubmittedAnswer> submitAnswers = [];
  int? selectedIndex;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: ColorRes.greyText,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: ColorRes.white,
          actions: [
            InkWell(
              onTap: () {
                NavigationUtils.pushAndRemoveUntil(context, routeDashboard,
                    arguments: {'index': 0});
              },
              child: Icon(
                Icons.clear,
                color: ColorRes.greyText,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: BlocBuilder<QuizDetailsBloc, QuizDetailsState>(
          builder: (context, state) {
            if (state is QuizDetailsSuccess) {
              return PageView.builder(
                itemCount: state.quizModel.content.length,
                onPageChanged: (index) {
                  initialPage = index;
                },
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: screenWidth(context: context),
                    height: screenHeight(context: context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 20),
                          child: Text(
                            state.quizModel.content[index].questionId!
                                .questionValue,
                            style: TextStyles.SB2575,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                state.quizModel.content[index].answers!.length >
                                        5
                                    ? Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 50, end: 50),
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 23,
                                                  mainAxisSpacing: 23,
                                                  childAspectRatio: 4 / 3),
                                          padding: EdgeInsets.all(0),
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: state.quizModel
                                              .content[index].answers!.length,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                state
                                                        .quizModel
                                                        .content[index]
                                                        .answers![i]
                                                        .isSelected =
                                                    !state
                                                        .quizModel
                                                        .content[index]
                                                        .answers![i]
                                                        .isSelected;

                                                setState(() {});
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            ColorRes.lightGrey,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: state
                                                            .quizModel
                                                            .content[index]
                                                            .answers![i]
                                                            .isSelected
                                                        ? ColorRes.primaryColor
                                                        : ColorRes.white),
                                                // padding: EdgeInsetsDirectional.fromSTEB(17, 28, 17, 28),
                                                // margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  state.quizModel.content[index]
                                                      .answers![i].answerValue,
                                                  style: state
                                                          .quizModel
                                                          .content[index]
                                                          .answers![i]
                                                          .isSelected
                                                      ? TextStyles.R1875
                                                          .copyWith(
                                                              color: ColorRes
                                                                  .white)
                                                      : TextStyles.R1875,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: state.quizModel
                                            .content[index].answers!.length,
                                        itemBuilder: (context, i) {
                                          if (state.quizModel.content[index]
                                                  .questionId!.questionType ==
                                              'Multiple') {
                                            return listItemMultipleChoice(
                                                state.quizModel.content[index]
                                                    .answers![i],
                                                state.quizModel.content[index]
                                                    .questionId!.questionType);
                                          } else if (state
                                                  .quizModel
                                                  .content[index]
                                                  .questionId!
                                                  .questionType ==
                                              'Singlechoice') {
                                            return listItemSingleChoice(
                                                state.quizModel.content[index],
                                                index,
                                                i);
                                          } else if (state
                                                  .quizModel
                                                  .content[index]
                                                  .questionId!
                                                  .questionType ==
                                              'Date') {
                                            return listItemDate(
                                                state.quizModel.content[index],
                                                index,
                                                i);
                                          } else {
                                            return listItemMultipleChoice(
                                                state.quizModel.content[index]
                                                    .answers![i],
                                                state.quizModel.content[index]
                                                    .questionId!.questionType);
                                          }
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                              onTap: () {
                                List<String> selectedAnswers = [];
                                if (state.quizModel.content[index].questionId!
                                        .questionType ==
                                    'Multiple') {
                                  state.quizModel.content[index].answers!
                                      .forEach((element) {
                                    if (element.isSelected) {
                                      selectedAnswers
                                          .add(element.id.toString());
                                    }
                                  });
                                } else if (state.quizModel.content[index]
                                        .questionId!.questionType ==
                                    'Singlechoice') {
                                  selectedAnswers.add(state
                                      .quizModel
                                      .content[index]
                                      .answers![state.quizModel.content[index]
                                          .questionId!.selectedIndex!]
                                      .id
                                      .toString());
                                } else if (state.quizModel.content[index]
                                        .questionId!.questionType ==
                                    'Date') {
                                  selectedAnswers.add(state.quizModel
                                      .content[index].answers![0].answerValue
                                      .toString());
                                }

                                SubmittedAnswer submit = SubmittedAnswer(
                                    questionId: state.quizModel.content[index]
                                        .questionId!.id,
                                    answer: selectedAnswers);
                                submitAnswers.add(submit);
                                if (index ==
                                    state.quizModel.content.length - 1) {
                                  // NavigationUtils.pushAndRemoveUntil(
                                  //     context, routeBreathLoader, arguments: {
                                  //   "questionAnswerList": submitAnswers
                                  // });
                                  NavigationUtils.push(
                                      context, routeBreathLoader, arguments: {
                                    "questionAnswerList": submitAnswers
                                  });
                                } else {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.easeIn);
                                }
                              },
                              buttonText:
                                  index == state.quizModel.content.length - 1
                                      ? AppLocalizations.of(context)!
                                          .translate('done')
                                      : AppLocalizations.of(context)!
                                          .translate('next'),
                              backgroundColor: ColorRes.green,
                              foregroundColor: ColorRes.white,
                              borderColor: ColorRes.green,
                              textStyle: TextStyles.SB18FF),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  );
                },
              );
            }
            if (state is QuizDetailsFailure) {
              return FailureWidget(message: state.message);
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }

  Widget listItemMultipleChoice(Answer answer, String questionType) {
    return InkWell(
      onTap: () {
        answer.isSelected = !answer.isSelected;

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: ColorRes.lightGrey, width: 1),
            borderRadius: BorderRadius.circular(10),
            color: answer.isSelected ? ColorRes.primaryColor : ColorRes.white),
        padding: EdgeInsetsDirectional.fromSTEB(20, 28, 0, 29),
        margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
        child: Text(
          answer.answerValue,
          style: answer.isSelected
              ? TextStyles.R1875.copyWith(color: ColorRes.white)
              : TextStyles.R1875,
        ),
      ),
    );
  }

  Widget listItemSingleChoice(
      Content content, int questionIndex, int answerIndex) {
    return InkWell(
      onTap: () {
        content.questionId!.selectedIndex = answerIndex;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorRes.lightGrey, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: content.questionId!.selectedIndex == answerIndex
              ? ColorRes.primaryColor
              : ColorRes.white,
        ),
        padding: EdgeInsetsDirectional.fromSTEB(20, 28, 0, 29),
        margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
        child: Text(
          content.answers![answerIndex].answerValue,
          style: content.questionId!.selectedIndex == answerIndex
              ? TextStyles.R1875.copyWith(color: ColorRes.white)
              : TextStyles.R1875,
        ),
      ),
    );
  }

  Widget listItemDate(Content content, int questionIndex, int answerIndex) {
    return InkWell(
      onTap: () async {
        DateTime? birthDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 100),
          lastDate: DateTime(DateTime.now().year + 100),
        );

        content.answers![answerIndex].answerValue =
            appState.formatDD.format(birthDate!);
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorRes.lightGrey, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: ColorRes.white,
        ),
        padding: EdgeInsetsDirectional.fromSTEB(20, 28, 0, 29),
        margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
        child: Text(
          content.answers![answerIndex].answerValue,
          style: TextStyles.R1875,
        ),
      ),
    );
  }
}

// class SubmitAnswers {
//   final int questionId;
//   final List<String> answers;
//
//   SubmitAnswers({required this.questionId, required this.answers});
// }
