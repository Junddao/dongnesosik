import 'package:dongnesosik/global/style/dstextstyle.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> _mockCheckForSession() async {
    bool result = false;
    // FirebaseAuth.instance.signOut();
    await Future.delayed(Duration(milliseconds: 2000), () {});

    return true;
  }

  @override
  void initState() {
    super.initState();

    _mockCheckForSession().then((value) async {
      if (value == true)
        _navigatorToHome();
      else {
        _navigatorToLogin();
      }
    });
  }

  void _navigatorToHome() {
    // UserProfileData userProfileData = new UserProfileData(
    //   _user.displayName,
    //   _user.photoURL,
    //   _user.email,
    //   _user.email, // id
    //   '',
    //   '',
    // );

    Navigator.of(context).pushNamed('PageTabs');
    // Navigator.of(context).pushNamed('OnBoardingScreenPage');
  }

  void _navigatorToLogin() {
    Navigator.of(context).pushNamed('LoginPage');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '동내소식!',
            style: DSTextStyle.bold26black,
          ),
        ],
      ),
    );
  }
}
