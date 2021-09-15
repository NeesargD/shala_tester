import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/blocs/classes/classes_details_bloc/classes_details_bloc.dart';
import 'package:shala_yoga/blocs/faq/faq_bloc.dart';
import 'package:shala_yoga/blocs/filter/get_filter/get_filter_bloc.dart';
import 'package:shala_yoga/blocs/home/home_bloc/home_bloc.dart';
import 'package:shala_yoga/blocs/programs/program_detail_bloc/program_detail_bloc.dart';
import 'package:shala_yoga/blocs/question_answer/question_answer_bloc.dart';
import 'package:shala_yoga/ui/dashboard/classes/classes_details_screen.dart';
import 'package:shala_yoga/ui/dashboard/programs/program_details_screen.dart';
import 'package:shala_yoga/ui/filter/filter_screen.dart';
import 'package:shala_yoga/ui/setting/language/language.dart';
import 'package:shala_yoga/ui/setting/notification/notification.dart';
import 'package:shala_yoga/ui/setting/subscription/subscription_screen.dart';
import 'package:shala_yoga/ui/setting/support/support_screen.dart';
import 'package:shala_yoga/ui/widgets/breathe_loader.dart';
import '../../../blocs/instructor_details_bloc/instructor_details_bloc.dart';
import '../../../blocs/recommended_bloc/recommendation_bloc.dart';
import '../../../ui/dashboard/dashboard_screen.dart';
import '../../../ui/dashboard/home/home.dart';
import '../../../ui/instructors/instructor_details_screen.dart';
import '../../../ui/setting/my_account/my_account_screen.dart';
import '../../../ui/setting/setting_screen.dart';

import '../../../blocs/instructor_bloc/instructor_bloc.dart';
import '../../../blocs/intro_bloc/intro_bloc.dart';
import '../../../blocs/quiz_details_bloc/quiz_details_bloc.dart';
import '../../../ui/Intro/intro_screen.dart';
import '../../../ui/auth/splash/splash_screen.dart';
import '../../../ui/dashboard/recommendation/recommendation_screen.dart';
import '../../../ui/instructors/instructor_screen.dart';
import '../../../ui/question_answer_screen.dart';
import '../../../ui/start_up/startup_screen.dart';
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
            create: (context) => RecommendationBloc()..add(GetRecommendationContent()),
            child: RecommendationScreen(),
          ),
        );
      case routeHomeScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => HomeBloc(),
                  child: HomeScreen(),
                ));

      case routeSubscription:
        return MaterialPageRoute(
            builder: (_) => SubscribeScreen());
      case routeInstructors:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => InstructorBloc(),
            child: InstructorScreen(),
          ),
        );
      case routeInstructorDetails:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => InstructorDetailsBloc()
              ..add(GetInstructorDetailsScreen(
                id: args!['id'],
              )),
            child: InstructorProfileScreen(),
          ),
        );
      case routeSetting:
        return MaterialPageRoute(
          builder: (_) => SettingScreen(),
        );
      case routeMyAccount:
        return MaterialPageRoute(
          builder: (_) => MyAccountScreen(),
        );
      case routeSupportScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => FaqBloc(),
            child: SupportScreen(),
          ),
        );
      case routeNotification:
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(),
        );
      case routeLanguage:
        return MaterialPageRoute(
          builder: (_) => LanguageScreen(),
        );
      case routeDashboard:
        return MaterialPageRoute(
            builder: (_) => DashboardScreen(
                  index: args!['index'],
                ));
      case routeBreathLoader:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => QuestionAnswerBloc(),
                  child: BreatheLoader(
                    questionAnswerList: args!['questionAnswerList'],
                  ),
                ));
      case routeFilterScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => GetFilterBloc(),
                  child: FilterScreen(),
                ));
      case routeClassDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ClassesDetailsBloc()
              ..add(GetClassDetails(
                id: args!['id'],
              )),
            child: ClassDetailsScreen(),
          ),
        );
      case routeProgramDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProgramDetailBloc()
              ..add(GetProgramDetail(
                id: args!['id'],
              )),
            child: ProgramDetailScreen(),
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
