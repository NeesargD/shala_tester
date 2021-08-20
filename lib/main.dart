import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'base/dependencyinjection/locator.dart';
import 'base/utils/constants/color_constant.dart';
import 'base/utils/navigation/navigation_route_constants.dart';
import 'base/utils/localization/localization.dart';
import 'base/utils/navigation/navigation_utils.dart';
import 'base/utils/preference_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await initializeDateFormatting();
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
        fontFamily: 'Sfui',
      ),
      onGenerateRoute: locator<NavigationUtils>().generateRoute,
      initialRoute: routeSplash,
      localizationsDelegates: [
        const MyLocalizationsDelegate(),
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        // const Locale('es', ''),
      ],
    );
  }
}





