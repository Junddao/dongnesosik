import 'package:dongnesosik/global/model/model_shared_preferences.dart';
import 'package:dongnesosik/global/model/user/model_request_guest_info.dart';
import 'package:dongnesosik/global/provider/user_provider.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> _isLogin() async {
    // FirebaseAuth.instance.signOut();
    await Future.delayed(Duration(milliseconds: 2000));

    String? myToken = await ModelSharedPreferences.readToken();
    ModelRequestGuestInfo modelRequestUserGuestInfo = ModelRequestGuestInfo(
      uid: ApiService.deviceIdentifier,
      osType: ApiService.osType,
      osVersion: ApiService.osVersion,
      deviceModel: ApiService.deviceModel,
    );

    if (myToken == '') {
      await getTokenAndUserInfo(modelRequestUserGuestInfo);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('PageLogin', (route) => false);
    } else {
      await context.read<UserProvider>().getUser().catchError((onError) async {
        await getTokenAndUserInfo(modelRequestUserGuestInfo);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageLogin', (route) => false);
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil('PageMap', (route) => false);
      // shared에 있는걸로 가져다 쓰기
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _isLogin();
    });
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
            style: DSTextStyles.bold26black,
          ),
        ],
      ),
    );
  }

  Future<void> getTokenAndUserInfo(
      ModelRequestGuestInfo modelRequestUserGuestInfo) async {
    await context.read<UserProvider>().createGuest(modelRequestUserGuestInfo);
    await context.read<UserProvider>().getUser();
  }
}
