import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:dongnesosik/global/model/model_config.dart';
import 'package:dongnesosik/global/model/model_shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info/package_info.dart';

class ApiService {
  static String deviceIdentifier = 'unknown';
  static String osType = '';
  static String osVersion = '';
  static String deviceModel = '';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, String> _multiPartHeaders = {
    'Content-Type': 'multipart/form-data',
    // 'utoken': deviceIdentifier,
  };

  Future<void> getDeviceUniqueId() async {
    var deviceInfo = DeviceInfoPlugin();
    var packageInfo = await PackageInfo.fromPlatform();
    osVersion = packageInfo.version;
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.androidId;
      deviceModel = androidInfo.model;
      osType = 'Android';
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor;
      deviceModel = iosInfo.model;
      osType = 'IOS';
    }
  }

  Future<dynamic> get(String _path) async {
    print('Api get : url $_path start.');
    var response;
    try {
      final token = await _getAuthorizationToken();
      print(token);
      _headers['dnss-token'] = '$token';
      print('${ModelConfig().serverBaseUrl}');
      response = await Dio()
          .get('${ModelConfig().serverBaseUrl}$_path',
              options: Options(
                headers: _headers,
              ))
          .timeout(Duration(seconds: 10));
      print('Api get : url ${ModelConfig().serverBaseUrl}$_path  done.');
      print('dio response = ${response.toString()}');
    } on DioError catch (e) {
      DioExceptions.fromDioError(e).toString();
      throw Exception();
    } on SocketException {
      print('No network');
      throw Exception();
    }
    return response?.data;
  }

  Future<dynamic> post(String _path, Map map) async {
    print('Api get : url $_path start.');

    var response;
    try {
      final token = await _getAuthorizationToken();
      print(token);
      _headers['dnss-token'] = '$token';

      var _data = jsonEncode(map);

      print('${ModelConfig().serverBaseUrl}');
      response = await Dio()
          .post(
            '${ModelConfig().serverBaseUrl}$_path',
            data: _data,
            options: Options(
              headers: _headers,
            ),
          )
          .timeout(Duration(seconds: 10));

      print('Api get : url ${ModelConfig().serverBaseUrl}$_path  done.');
      print('dio response = ${response.toString()}');
    } on DioError catch (e) {
      print(e.error.toString());
      DioExceptions.fromDioError(e).toString();
      throw Exception();
    } on SocketException {
      print('No network');
      throw Exception();
    }
    return response?.data;
  }

  Future<dynamic> postWithOutToken(String _path, Map map) async {
    print('Api get : url $_path start.');

    var response;
    try {
      var _data = jsonEncode(map);

      print('${ModelConfig().serverBaseUrl}');
      response = await Dio()
          .post(
            '${ModelConfig().serverBaseUrl}$_path',
            data: _data,
            options: Options(
              headers: _headers,
            ),
          )
          .timeout(Duration(seconds: 10));

      print('Api get : url ${ModelConfig().serverBaseUrl}$_path  done.');
      print('dio response = ${response.toString()}');
    } on DioError catch (e) {
      DioExceptions.fromDioError(e).toString();
    } on SocketException {
      print('No network');
    } catch (e) {
      print(e);
    }
    return response?.data;
  }

  Future<dynamic> postMultiPart(
      String _path, List<File> _files, String type) async {
    print('Api get : url $_path start.');

    // final token = await _getAuthorizationToken();
    // print(token);
    // print('${ConfigModel().serverBaseUrl}');
    var response;
    try {
      // _multiPartHeaders['dnss-token'] = '$token';
      var _formData = FormData();
      for (int i = 0; i < _files.length; i++) {
        _formData.files.add(
          MapEntry(
            type,
            await MultipartFile.fromFile(_files[i].path),
          ),
        );
      }

      print('path = ${ModelConfig().serverBaseUrl}$_path');

      response = await Dio()
          .post('${ModelConfig().serverBaseUrl}$_path',
              data: _formData,
              options: Options(
                headers: _multiPartHeaders,

                // followRedirects: false,
                // validateStatus: (status) {
                //   return status! < 500;
                // },
              ))
          .timeout(Duration(seconds: 30));

      print('Api get : url ${ModelConfig().serverBaseUrl}$_path  done.');
      print('dio response = ${response.toString()}');
    } on DioError catch (e) {
      DioExceptions.fromDioError(e).toString();
    } on SocketException {
      print('No network');
    }
    return response?.data;
  }

  Future<dynamic> getGoogleGeoApi(String location) async {
    print('Api get : url $location start.');
    String _path =
        'https://maps.googleapis.com/maps/api/geocode/json?$location&language=ko&key=AIzaSyAoeKpyN_EODABnnIV_Wdx7Tu8Y1QECowY';
    var response;
    try {
      response = await Dio()
          .get(_path,
              options: Options(
                headers: _headers,
              ))
          .timeout(Duration(seconds: 10));
      print('Api get : url $_path  done.');
      print('dio response = ${response.toString()}');
    } on DioError catch (e) {
      DioExceptions.fromDioError(e).toString();
    } on SocketException {
      print('No network');
    }
    return response?.data;
  }
}

Future<String?> _getAuthorizationToken() async {
  var token = await ModelSharedPreferences.readToken();
  return token;
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    String? message;
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }
  // 401 - 토큰이깨지거나 만료되거나
  // Message 로 아래의 내용전송
  // invalid signature
  // token expired
  // not supported token
  // invalid token

  // 403 - 권한없음
  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'token expired';
      case 403:
        return 'no authorized';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }
}
