import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ModelSharedPreferences {
  static String TOKEN = 'token';

  static Future<String?> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(TOKEN)) {
      return prefs.getString(TOKEN)!;
    }
    return '';
  }

  static Future<void> writeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = token;
    prefs.setString(TOKEN, token);
  }

  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(TOKEN)) {
      prefs.remove(TOKEN);
    }
  }
}
