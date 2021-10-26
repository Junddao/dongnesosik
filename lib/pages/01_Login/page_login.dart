import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dongnesosik/global/provider/auth_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      // backgroundColor: DSColors.tomato,
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
              child: SizedBox(
                width: 200.0,
                child: TextLiquidFill(
                  text: '동내소식',
                  waveColor: DSColors.black,
                  boxBackgroundColor: DSColors.white,
                  textStyle: DSTextStyles.bold40white,
                  boxHeight: 300.0,
                ),
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
                    AuthProvider().signInWithGoogle();
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
                          AuthProvider().signInWithApple();
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
