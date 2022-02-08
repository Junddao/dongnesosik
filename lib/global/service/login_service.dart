import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:dongnesosik/global/model/model_config.dart';
import 'package:dongnesosik/global/model/model_shared_preferences.dart';
import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/model/user/model_request_guest_info.dart';
import 'package:dongnesosik/global/model/user/model_response_sign_in.dart';
import 'package:dongnesosik/global/model/user/moder_request_sign_in.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginService {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      return authResult.user;
    } catch (error) {
      print('error');
      throw Exception();
    }
  }

  Future<void> signInWithKakao(String token) async {
    final Map<String, dynamic> data = await LoginService().kakaoLogin(token);

    String customToken = data['customToken'] ?? '';
    String email = data['email'] ?? '';

    fb.UserCredential? result = await _auth.signInWithCustomToken(customToken);

    fb.User? firebaseUser = result.user;

    // if (SingletonUser.singletonUser.userData.name!.isEmpty) {
    //   await signIn(firebaseUser);
    // } else {
    await connect(firebaseUser).catchError((onError) async {
      await signIn(firebaseUser);
    });
    // }

    // aws server에 token 요청
  }

  Future<void> signIn(fb.User? firebaseUser) async {
    // String idToken = await firebaseUser!.getIdToken();
    ModelReqeustSignIn signInRequestModel =
        await LoginService().getSignInRequest(firebaseUser);

    var api = ApiService();
    // Map<String, dynamic> map = {
    //   'firebaseIdToken': idToken,
    //   'osType' : osType,
    //   'osVersion': osVersion,
    //   'deviceModel': deviceModel,
    // };

    Map<String, dynamic> _data =
        await api.post('/user/signin', signInRequestModel.toMap());
    ModelResponseSignIn signInResponseModel =
        ModelResponseSignIn.fromMap(_data['data']);
    ModelSharedPreferences.writeToken(signInResponseModel.accessToken!);
  }

  Future<void> connect(fb.User? firebaseUser) async {
    // String idToken = await firebaseUser!.getIdToken();
    ModelReqeustSignIn signInRequestModel =
        await LoginService().getSignInRequest(firebaseUser);

    var api = ApiService();
    // Map<String, dynamic> map = {
    //   'firebaseIdToken': idToken,
    //   'osType' : osType,
    //   'osVersion': osVersion,
    //   'deviceModel': deviceModel,
    // };

    Map<String, dynamic> _data =
        await api.post('/user/connect', signInRequestModel.toMap());
    ModelResponseSignIn signInResponseModel =
        ModelResponseSignIn.fromMap(_data['data']);
    ModelSharedPreferences.writeToken(signInResponseModel.accessToken!);
  }

  Future<Map<String, dynamic>> kakaoLogin(String token) async {
    final String _path = "/user/verification";
    final map = {
      "type": "kakao",
      "token": token,
    };
    final _headers = {"Content-Type": "application/json"};

    var _data = jsonEncode(map);

    print('${ModelConfig().serverBaseUrl}');
    var response = await Dio()
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
    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      print('error : ${response.statusCode} failed to login with token');
      print(response.data);
      throw Exception("${response.statusCode} failed to login with token");
    }
    //
  }

  Future<ModelResponseSignIn> createToken() async {
    // String idToken = await firebaseUser!.getIdToken();
    ModelRequestGuestInfo modelRequestGuestInfo =
        await LoginService().getGuestToken();

    var api = ApiService();
    // Map<String, dynamic> map = {
    //   'firebaseIdToken': idToken,
    //   'osType' : osType,
    //   'osVersion': osVersion,
    //   'deviceModel': deviceModel,
    // };

    Map<String, dynamic> _data =
        await api.post('/user/create/guest', modelRequestGuestInfo.toMap());
    ModelResponseSignIn signInResponseModel =
        ModelResponseSignIn.fromMap(_data['data']);
    ModelSharedPreferences.writeToken(signInResponseModel.accessToken!);

    return signInResponseModel;
  }

  Future<ModelReqeustSignIn> getSignInRequest(firebaseUser) async {
    ModelReqeustSignIn modelRequestSignIn = ModelReqeustSignIn();
    var deviceInfo = DeviceInfoPlugin();

    String? firebaseIdToken = await firebaseUser!.getIdToken();
    String? deviceModel = '';
    String? osType = '';
    String? osVersion = '';

    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;

      deviceModel = androidInfo.model;
      osType = 'Android';
      osVersion = "Android $release (SDK $sdkInt)";
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      var version = iosInfo.systemVersion;
      var machine = iosInfo.utsname.machine;

      deviceModel = machine;
      osType = 'IOS';
      osVersion = version;
    }

    modelRequestSignIn.firebaseIdToken = firebaseIdToken;
    modelRequestSignIn.deviceModel = deviceModel;
    modelRequestSignIn.osType = osType;
    modelRequestSignIn.osVersion = osVersion;
    modelRequestSignIn.uid = ApiService.deviceIdentifier;

    return modelRequestSignIn;
  }

  Future<ModelRequestGuestInfo> getGuestToken() async {
    ModelRequestGuestInfo modelRequestGuestInfo = ModelRequestGuestInfo();
    var deviceInfo = DeviceInfoPlugin();

    String? deviceModel = '';
    String? osType = '';
    String? osVersion = '';

    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;

      deviceModel = androidInfo.model;
      osType = 'Android';
      osVersion = "Android $release (SDK $sdkInt)";
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      var version = iosInfo.systemVersion;
      var machine = iosInfo.utsname.machine;

      deviceModel = machine;
      osType = 'IOS';
      osVersion = version;
    }

    modelRequestGuestInfo.deviceModel = deviceModel;
    modelRequestGuestInfo.osType = osType;
    modelRequestGuestInfo.osVersion = osVersion;
    modelRequestGuestInfo.uid = ApiService.deviceIdentifier;

    return modelRequestGuestInfo;
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return '로그아웃 실패. 다시 시도해주세요.';
    }
  }
}
