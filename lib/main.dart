import 'dart:convert';
import 'dart:io';

import 'package:dongnesosik/global/model/model_config.dart';
import 'package:dongnesosik/global/provider/file_provider.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';

import 'package:dongnesosik/global/provider/user_provider.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/pages/00_Intro/page_splash.dart';

import 'package:dongnesosik/route.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runServer();
}

runServer() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await ApiService().getDeviceUniqueId();

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
              ChangeNotifierProvider(create: (_) => UserProvider()),
              ChangeNotifierProvider(create: (_) => FileProvider()),
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
              home: PageSplash(),
              builder: EasyLoading.init(),
            ),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
