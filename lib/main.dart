import 'dart:convert';

import 'package:dongnesosik/global/model/model_config.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/pages/00_Intro/page_splash.dart';

import 'package:dongnesosik/route.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ModelConfig().fromJson(configObject);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("firebase load fail"),
            );
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => LocationProvider()),
            ],
            child: MaterialApp(
              theme: ThemeData(
                  primaryColor: Colors.white,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  accentColor: DSColors.tomato,
                  appBarTheme: AppBarTheme(
                    color: DSColors.white,
                    foregroundColor: DSColors.black,
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
        });
  }
}
