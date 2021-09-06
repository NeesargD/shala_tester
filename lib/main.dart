import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shala_yoga/base/utils/localization/app_language.dart';
import 'base/dependencyinjection/locator.dart';
import 'base/utils/constants/color_constant.dart';
import 'base/utils/localization/app_localizations.dart';
import 'base/utils/navigation/navigation_route_constants.dart';
import 'base/utils/localization/localization.dart';
import 'base/utils/navigation/navigation_utils.dart';
import 'base/utils/preference_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  // await initializeDateFormatting();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => AppLanguage(),
      lazy: false,
      child: Consumer<AppLanguage>(
        builder: (context, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Base Project',
            // builder: (context, child) {
            //   return MediaQuery(
            //     child: child!,
            //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            //   );
            // },
            theme: ThemeData(
              primaryColor: ColorRes.primaryColor,
              primaryColorDark: ColorRes.primaryColor,
              accentColor: ColorRes.primaryColor,
              primarySwatch: Colors.green,
              fontFamily: 'Sfui',
            ),
            onGenerateRoute: locator<NavigationUtils>().generateRoute,
            initialRoute: routeSplash,
            locale: model.appLocal,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales:  [
              Locale('en', ''), // English, no country code
              Locale('ar', ''), // Arabic, no country code
            ],
          );
        },
      ),
    );
  }
}





