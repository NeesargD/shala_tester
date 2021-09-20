import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shala_yoga/base/utils/localization/app_language.dart';
import 'base/dependencyinjection/locator.dart';
import 'base/utils/constants/color_constant.dart';
import 'base/utils/localization/app_localizations.dart';
import 'base/utils/navigation/navigation_route_constants.dart';
import 'base/utils/navigation/navigation_utils.dart';
import 'base/utils/preference_utils.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  configLoading();

  if (Platform.isAndroid) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }

  await Firebase.initializeApp();
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
    final botToastBuilder = BotToastInit();
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => AppLanguage(),
      lazy: false,
      child: Consumer<AppLanguage>(
        builder: (context, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shalaonline',
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
            builder: (context, child) {
              child = botToastBuilder(context, FlutterEasyLoading(child: child));
              return child;
            },
            supportedLocales:  [
              Locale('en', ''), // English, no country code
              Locale('ar', ''), // Arabic, no country code
            ],
            navigatorObservers: [BotToastNavigatorObserver()],
          );
        },
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..maskType = EasyLoadingMaskType.custom
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 100
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.white
    ..textColor = Colors.yellow
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false;
}





