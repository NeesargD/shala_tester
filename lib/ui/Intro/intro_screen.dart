import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:introduction_screen/introduction_screen.dart";
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';

import '../../../base/extensions/scaffold_extension.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../blocs/intro_bloc/intro_bloc.dart';
import '../widgets/failure_widget.dart';
import '../widgets/loading_widget.dart';

class OnboardScreen extends StatefulWidget {
  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    NavigationUtils.pushReplacement(context, routeStartUpScreen);
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      titleTextStyle:
          TextStyle(color: ColorRes.white, fontSize: 35, letterSpacing: 0),
      bodyTextStyle:
          TextStyle(letterSpacing: 0, fontSize: 15, color: ColorRes.white),
      descriptionPadding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      pageColor: ColorRes.primaryColor,
      imagePadding: EdgeInsets.zero,
      contentMargin: EdgeInsets.zero,
      imageFlex: 2,
      imageAlignment: Alignment.center,
      titlePadding: EdgeInsets.zero,
      bodyAlignment: Alignment.centerLeft,
    );

    return BlocBuilder<IntroBloc, IntroState>(
      builder: (context, state) {
        if (state is IntroFailure) {
          return FailureWidget(message: state.message);
        }
        if (state is IntroSuccess) {
          return IntroductionScreen(
            key: introKey,
            globalBackgroundColor: ColorRes.primaryColor,
            pages: state.onboardingModel.content!.page
                .map((e) => PageViewModel(
                      image: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SvgPicture.network(
                          e.image,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                          height: screenHeight(context: context, percent: 0.45),
                          width: screenWidth(context: context),
                        ),
                      ),
                      titleWidget: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsetsDirectional.only(start: 30),
                        child: Text(
                          e.splashTitle,
                          style: TextStyle(
                            color: ColorRes.white,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      bodyWidget: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsetsDirectional.only(start: 30, end: 10),
                        child: Text(
                          e.splashText,
                          style: TextStyle(
                              color: ColorRes.white,
                              fontSize: 25,
                              letterSpacing: 0),
                        ),
                      ),
                      decoration: pageDecoration,
                    ))
                .toList(),
            onDone: () => _onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            //rtl: true, // Display as right-to-left
            skip: Text(
              AppLocalizations.of(context)!.translate("skip"),
              style: TextStyle(color: ColorRes.white),
            ),
            next: const Icon(
              Icons.arrow_forward,
              color: ColorRes.white,
            ),
            done: Text(
              AppLocalizations.of(context)!.translate('done'),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ColorRes.white,
              ),
            ),
            // isTopSafeArea: true,
            // isBottomSafeArea: true,
            curve: Curves.fastLinearToSlowEaseIn,
            controlsPadding: kIsWeb
                ? const EdgeInsets.all(12.0)
                : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: ColorRes.indicatorColor,
              activeSize: Size(22.0, 10.0),
              activeColor: ColorRes.white,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            dotsContainerDecorator: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          );
        }
        return LoadingWidget();
      },
    ).baseScaffold(context: context);
  }
}
