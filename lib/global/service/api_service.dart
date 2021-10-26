import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dongnesosik/global/model/model_config.dart';

class ApiService {
  static String deviceIdentifier = 'unknown';
  static String appVersion = '';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, String> _multiPartHeaders = {
    'Content-Type': 'multipart/form-data',
    'utoken': deviceIdentifier,
  };

  Future<dynamic> get(String _path) async {
    print('Api get : url $_path start.');
    var response;
    try {
      // final token = await _getAuthorizationToken();
      // print(token);
      // _headers['Credi-Token'] = '$token';
      print('${ModelConfig().serverBaseUrl}');
      response = await Dio()
          .get('${ModelConfig().serverBaseUrl}$_path',
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

  Future<dynamic> post(String _path, Map map) async {
    print('Api get : url $_path start.');

    // final token = await _getAuthorizationToken();
    // print(token);
    var response;
    try {
      // _headers['Credi-Token'] = '$token';

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

      print('Api get : url $_path  done.');
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
      // _multiPartHeaders['Credi-Token'] = '$token';
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

      print('Api get : url $_path  done.');
      print('dio response = ${response.toString()}');
    } on DioError catch (e) {
      DioExceptions.fromDioError(e).toString();
    } on SocketException {
      print('No network');
    }
    return response?.data;
  }

  Future<dynamic> getGoogleGeoApi(String _path) async {
    print('Api get : url $_path start.');
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
