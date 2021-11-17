import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModelSharedPreferences {
  static String TOKEN = 'token';
  static String MYLAT = 'myLat';
  static String MYLNG = 'myLng';
  static String ADDRESS = 'address';

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

  static Future<double?> readMyLat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(MYLAT)) {
      return prefs.getDouble(MYLAT)!;
    }
    return 0;
  }

  static Future<void> writeMyLat(double lat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lat = lat;
    prefs.setDouble(MYLAT, lat);
  }

  static Future<void> removeMyLat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(MYLAT)) {
      prefs.remove(MYLAT);
    }
  }

  static Future<double?> readMyLng() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(MYLNG)) {
      return prefs.getDouble(MYLNG)!;
    }
    return 0;
  }

  static Future<void> writeMyLng(double lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lng = lng;
    prefs.setDouble(MYLNG, lng);
  }

  static Future<void> removeMyLng() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(MYLNG)) {
      prefs.remove(MYLNG);
    }
  }

  static Future<void> removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(MYLNG)) {
      prefs.remove(MYLNG);
    }
    if (prefs.containsKey(MYLAT)) {
      prefs.remove(MYLAT);
    }
    if (prefs.containsKey(TOKEN)) {
      prefs.remove(TOKEN);
    }
  }
}
