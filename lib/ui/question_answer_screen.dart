import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';

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
              onTap: (){
                NavigationUtils.pushAndRemoveUntil(context, routeDashboard,arguments: {'index':0});
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
                            state.quizModel.content[index].questionId!.questionValue,
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
                                state.quizModel.content[index].answers!.length > 5
                                    ? Padding(
                                        padding: const EdgeInsetsDirectional.only(start: 50, end: 50),
                                        child: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 23,
                                              mainAxisSpacing: 23,
                                              childAspectRatio: 4 / 3),
                                          padding: EdgeInsets.all(0),
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: state.quizModel.content[index].answers!.length,
                                          itemBuilder: (context, i) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(color: ColorRes.lightGrey, width: 1),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              // padding: EdgeInsetsDirectional.fromSTEB(17, 28, 17, 28),
                                              // margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                                              alignment: Alignment.center,
                                              child: Text(
                                                state.quizModel.content[index].answers![i].answerValue,
                                                style: TextStyles.R1875,
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: state.quizModel.content[index].answers!.length,
                                        itemBuilder: (context, i) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: ColorRes.lightGrey, width: 1),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsetsDirectional.fromSTEB(20, 28, 0, 29),
                                            margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                                            child: Text(
                                              state.quizModel.content[index].answers![i].answerValue,
                                              style: TextStyles.R1875,
                                            ),
                                          );
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
                                if (index == state.quizModel.content.length - 1) {
                                  NavigationUtils.pushAndRemoveUntil(context, routeDashboard, arguments: {"index": 5});
                                } else {
                                  _pageController.nextPage(duration: Duration(milliseconds: 350), curve: Curves.easeIn);
                                }
                              },
                              buttonText: AppLocalizations.of(context)!.translate('next'),
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
}
