import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dongnesosik/global/model/user/model_request_user_connect.dart';
import 'package:dongnesosik/global/model/user/model_request_user_set.dart';
import 'package:dongnesosik/global/provider/auth_provider.dart';
import 'package:dongnesosik/global/provider/user_provider.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
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
      child: Column(
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
              //       WavyAnimatedText('동내소식'),
              //     ],
              //     isRepeatingAnimation: true,
              //   ),
              // ),

              child: TextLiquidFill(
                text: '동내소식',
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
                InkWell(
                  onTap: () async {
                    User? user = await AuthProvider().signInWithGoogle();
                    String firebaseIdToken = await user!.getIdToken();
                    ModelReqeustUserConnect modelReqeustUserConnect =
                        ModelReqeustUserConnect(
                      firebaseIdToken: firebaseIdToken,
                      deviceModel: ApiService.deviceModel,
                      osType: ApiService.osType,
                      osVersion: ApiService.osVersion,
                      uid: ApiService.deviceIdentifier,
                    );
                    await context
                        .read<UserProvider>()
                        .userConnect(modelReqeustUserConnect);

                    ModelRequestUserSet modelRequestUserSet =
                        ModelRequestUserSet(
                      email: user.email ?? '',
                      name: user.displayName ?? '',
                      phoneNumber: user.phoneNumber ?? '',
                      profileImage: user.photoURL ?? '',
                    );

                    await context
                        .read<UserProvider>()
                        .setUser(modelRequestUserSet);

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('PageMap', (route) => false);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 48,
                        width: SizeConfig.screenWidth * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: DSColors.tomato),
                        child: Center(
                            child: Text('Google로 로그인',
                                style: DSTextStyles.bold16White)),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Icon(
                          FontAwesomeIcons.google,
                          size: 24,
                          color: DSColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Platform.isIOS
                    ? InkWell(
                        onTap: () async {
                          User? user = await AuthProvider().signInWithApple();
                          String firebaseIdToken = await user!.getIdToken();
                          ModelReqeustUserConnect modelReqeustUserConnect =
                              ModelReqeustUserConnect(
                            firebaseIdToken: firebaseIdToken,
                            deviceModel: ApiService.deviceModel,
                            osType: ApiService.osType,
                            osVersion: ApiService.osVersion,
                            uid: ApiService.deviceIdentifier,
                          );
                          await context
                              .read<UserProvider>()
                              .userConnect(modelReqeustUserConnect);

                          ModelRequestUserSet modelRequestUserSet =
                              ModelRequestUserSet(
                            email: user.email ?? '',
                            name: user.displayName ?? '이름없음',
                            phoneNumber: user.phoneNumber ?? '',
                            profileImage: user.photoURL ?? '',
                          );

                          await context
                              .read<UserProvider>()
                              .setUser(modelRequestUserSet);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'PageMap', (route) => false);
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 48,
                              width: SizeConfig.screenWidth * 0.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: DSColors.black),
                              child: Center(
                                  child: Text('Apple로 로그인',
                                      style: DSTextStyles.bold16White)),
                            ),
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Icon(
                                FontAwesomeIcons.apple,
                                size: 24,
                                color: DSColors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () async {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('PageMap', (route) => false);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 48,
                        width: SizeConfig.screenWidth * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.transparent),
                        child: Center(
                            child: Text('Guest로 계속 사용하기',
                                style:
                                    DSTextStyles.regular12WarmGrey_underline)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
