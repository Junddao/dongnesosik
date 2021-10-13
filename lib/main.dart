import 'dart:convert';

import 'package:dongnesosik/global/model/config_model.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/style/jcolors.dart';
import 'package:dongnesosik/page_tabs.dart';
import 'package:dongnesosik/pages/01_Intro/page_splash.dart';

import 'package:dongnesosik/route.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runServer();
}

runServer() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await readConfigFile();
  runApp(
    MyApp(),
  );
}

Future<void> readConfigFile() async {
  var configJson;

  configJson = await rootBundle.loadString('assets/texts/config.json');

  print(configJson);
  final configObject = jsonDecode(configJson);
  ConfigModel().fromJson(configObject);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            accentColor: JColors.tomato,
            appBarTheme: AppBarTheme(
              color: JColors.white,
              foregroundColor: JColors.black,
              elevation: 0,
            ),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.white),
        onGenerateRoute: Routers.generateRoute,
        home: SplashScreen(),
      ),
    );
  }
}
