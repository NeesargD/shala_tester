import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/blocs/instructor_bloc/instructor_bloc.dart';
import 'package:shala_yoga/blocs/intro_bloc/intro_bloc.dart';
import 'package:shala_yoga/blocs/quiz_details_bloc/quiz_details_bloc.dart';
import 'package:shala_yoga/ui/Intro/intro_screen.dart';
import 'package:shala_yoga/ui/Intro/splashScreen.dart';
import 'package:shala_yoga/ui/instuctors/instructor_screen.dart';
import 'package:shala_yoga/ui/question_answer_screen.dart';
import 'package:shala_yoga/ui/recommendation/recommendation_screen.dart';
import 'package:shala_yoga/ui/start_up/startup_screen.dart';

import '../../../ui/auth/splash/splash_screen.dart';
import 'navigation_route_constants.dart';

class NavigationUtils {
  Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case routeSplash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case routeIntro:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => IntroBloc()..add(GetIntroScreens()),
            child: OnboardScreen(),
          ),
        );
      case routeStartUpScreen:
        return MaterialPageRoute(builder: (_) => StartUpScreen());
      case routeQuestionAnswer:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => QuizDetailsBloc()..add(GetQuizDetails()),
            child: QuestionAnswerScreen(),
          ),
        );
      case routeRecommendation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => QuizDetailsBloc(),
            child: RecommendationScreen(),
          ),
        );
      case routeInstructors:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => InstructorBloc(),
            child: InstructorScreen(),
          ),
        );
      default:
        return _errorRoute(" Coming soon...");
    }
  }

  Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(appBar: AppBar(title: Text('Error')), body: Center(child: Text(message)));
    });
  }

  static void pushReplacement(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> push(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void pop(BuildContext context, {dynamic args}) {
    Navigator.of(context).pop(args);
  }

  static Future<dynamic> pushAndRemoveUntil(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }
}
