import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dongnesosik/global/model/model_shared_preferences.dart';
import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/model/user/model_request_user_connect.dart';
import 'package:dongnesosik/global/model/user/model_request_user_set.dart';
import 'package:dongnesosik/global/provider/auth_provider.dart';
import 'package:dongnesosik/global/provider/user_provider.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:dongnesosik/global/service/login_service.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/global/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/all.dart' as kakao;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: DSColors.white,
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: isLoading == true
          ? CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Center(
                    // child: DefaultTextStyle(
                    //   style: DSTextStyles.bold40black,
                    //   child: AnimatedTextKit(

                    //     animatedTexts: [
                    //       WavyAnimatedText('DongNe'),
                    //       WavyAnimatedText('SoSik'),
                    //       WavyAnimatedText('동네소식'),
                    //     ],
                    //     isRepeatingAnimation: true,
                    //   ),
                    // ),

                    child: TextLiquidFill(
                      text: '동네소식',
                      waveColor: DSColors.black,
                      boxBackgroundColor: DSColors.white,
                      textStyle: DSTextStyles.bold40white,
                      // boxHeight: 300.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildKakaoLogin(),
                      Platform.isIOS
                          ? SizedBox(height: 20.0)
                          : SizedBox.shrink(),
                      Platform.isIOS ? _buildAppleLogin() : SizedBox.shrink(),
                      SizedBox(height: 40.0),
                      _buildGuestLogin(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  _buildAppleLogin() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        await _loginWithApple();
      },
      child: Container(
        width: size.width - 40,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 22),
            Icon(
              FontAwesomeIcons.apple,
              size: 24,
              color: DSColors.white,
            ),
            Spacer(),
            Text('Apple로 로그인', style: DSTextStyles.regular18white),
            Spacer(),
            const SizedBox(width: 24),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  _loginWithApple() async {
    setState(() {
      isLoading = true;
    });

    User? user = await AuthProvider().signInWithApple();
    String firebaseIdToken = await user!.getIdToken();

    // guest 상태 면 connect , 처음이면 sign in
    // if (SingletonUser.singletonUser.userData.name!.isEmpty) {
    //   await LoginService().signIn(user);
    // } else {
    await LoginService().connect(user).catchError((onError) async {
      await LoginService().signIn(user);
    });
    // }

    try {
      // set 해주고
      ModelRequestUserSet modelRequestUserSet = ModelRequestUserSet.fromMap(
          SingletonUser.singletonUser.userData.toUserSetMap());

      modelRequestUserSet.email = user.email ?? '';
      modelRequestUserSet.name = user.displayName ?? '이름없음';
      modelRequestUserSet.phoneNumber = user.phoneNumber ?? '';
      modelRequestUserSet.profileImage = user.photoURL ?? '';

      await context.read<UserProvider>().setUser(modelRequestUserSet);

      // 최종본 get
      await context.read<UserProvider>().getMe();

      double? myLat = await ModelSharedPreferences.readMyLat();
      double? myLng = await ModelSharedPreferences.readMyLng();

      if (myLat == 0 && myLng == 0) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageSetLocation', (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageMap', (route) => false);
      }
    } catch (e) {
      logger.v(e.toString());
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
        content: Text('${e.toString()}'),
      )));
    } finally {
      _stopLoading();
    }
  }

  _buildKakaoLogin() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        await _loginWithKakao();
      },
      child: Container(
        width: size.width - 40,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.yellow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 22),
            Image.asset(
              "assets/images/ic_logo_kakao.png",
              width: 24,
              height: 24,
            ),
            Spacer(),
            Text('카카오로 로그인', style: DSTextStyles.regular18black),
            Spacer(),
            const SizedBox(width: 24),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  _loginWithKakao() async {
    setState(() {
      isLoading = true;
    });
    try {
      final isKakaoInstalled = await kakao.isKakaoTalkInstalled();

      var code = isKakaoInstalled
          ? await kakao.AuthCodeClient.instance.requestWithTalk()
          // ? await kakao.AuthCodeClient.instance.request()
          : await kakao.AuthCodeClient.instance.request();
      print(code);
      await _issueAccessToken(code);
    } catch (e) {
      logger.e(e.toString());
      _stopLoading();
    }
  }

  _issueAccessToken(String authCode) async {
    Logger().v("authCode : $authCode");
    try {
      var token = await kakao.AuthApi.instance.issueAccessToken(authCode);
      var tokenManager = kakao.DefaultTokenManager();
      await tokenManager.setToken(token);

      logger.v(token.toJson());
      // Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => Home()
      //     ));
      var user = await kakao.UserApi.instance.me();
      var email = user.kakaoAccount!.email!;
      var nickName = user.kakaoAccount!.profile!.nickname;
      var profileImageUrl = user.kakaoAccount!.profile!.profileImageUrl;
      if (user.kakaoAccount == null) {
        logger.v(user.kakaoAccount!.email);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          content: Text('이메일이 없습니다.'),
        )));
        _stopLoading();
        return;
      }
      logger.v(user.toJson());
      final String accessToken = token.toJson()["access_token"].toString();
      // logger.v("kakao token: ${accessToken}");
      _createKakaoAccountRequest(
          accessToken, email, nickName!, profileImageUrl!);
    } catch (e) {
      logger.v(e.toString());
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
        content: Text('${e.toString()}'),
      )));
      _stopLoading();
    }
  }

  void _createKakaoAccountRequest(
      String token, String email, String nickName, String profileImage) async {
    LoginService()
        .signInWithKakao(token)
        .catchError(_onErrorLogin)
        .then((result) async {
      // server에  getuser 해서 가져오고
      await context.read<UserProvider>().getMe();

      SingletonUser.singletonUser.userData.email = email;
      SingletonUser.singletonUser.userData.name = nickName;
      SingletonUser.singletonUser.userData.profileImage = profileImage;

      // set 해주고
      ModelRequestUserSet modelRequestUserSet = ModelRequestUserSet.fromMap(
          SingletonUser.singletonUser.userData.toUserSetMap());

      modelRequestUserSet.email = email;
      modelRequestUserSet.name = nickName;
      modelRequestUserSet.phoneNumber = '';
      modelRequestUserSet.profileImage = profileImage;
      await context.read<UserProvider>().setUser(modelRequestUserSet);

      // 최종본 get
      await context.read<UserProvider>().getMe();

      double? myLat = await ModelSharedPreferences.readMyLat();
      double? myLng = await ModelSharedPreferences.readMyLng();

      if (myLat == 0 && myLng == 0) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageSetLocation', (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageMap', (route) => false);
      }
      // singleton에 넣고
      // shared에 넣고

      _stopLoading();

      // 페이지 전환
    });
  }

  _buildGuestLogin() {
    return Container(
      width: double.infinity,
      height: 50,
      child: Center(
        child: InkWell(
          onTap: () async {
            double? myLat = await ModelSharedPreferences.readMyLat();
            double? myLng = await ModelSharedPreferences.readMyLng();

            if (myLat == 0 && myLng == 0) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('PageSetLocation', (route) => false);
            } else {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('PageMap', (route) => false);
            }
          },
          child:
              Text('Guest로 둘러보기', style: DSTextStyles.regular12BlackUnderLine),
        ),
      ),
    );
  }

  _stopLoading() {
    if (isLoading == true) {
      setState(() {
        isLoading = false;
      });
    }
  }

  _onErrorLogin(Object error) {
    _stopLoading();
    print('kakao login error');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$error'),
    ));
  }
}
