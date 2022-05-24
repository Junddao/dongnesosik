import 'package:dongnesosik/global/enums/user_state.dart';
import 'package:dongnesosik/global/model/model_shared_preferences.dart';
import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/model/user/model_request_guest_info.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/provider/user_provider.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

class PageSplash extends StatefulWidget {
  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  Future<bool> _isLogin() async {
    // FirebaseAuth.instance.signOut();
    await Future.delayed(Duration(milliseconds: 2000));

    String? myToken = await ModelSharedPreferences.readToken();
    double? myLat = await ModelSharedPreferences.readMyLat();
    double? myLng = await ModelSharedPreferences.readMyLng();
    ModelRequestGuestInfo modelRequestUserGuestInfo = ModelRequestGuestInfo(
      uid: ApiService.deviceIdentifier,
      osType: ApiService.osType,
      osVersion: ApiService.osVersion,
      deviceModel: ApiService.deviceModel,
    );

    if (myToken == '') {
      await getTokenAndUserInfo(modelRequestUserGuestInfo);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('PageAgreement', (route) => false);
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil('PageLogin', (route) => false);
    } else {
      await context.read<UserProvider>().getMe().catchError((onError) async {
        await getTokenAndUserInfo(modelRequestUserGuestInfo);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageLogin', (route) => false);
      });
      if (SingletonUser.singletonUser.userData.state ==
          describeEnum(UserState.block)) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageBlock', (route) => false);
      } else {
        if (myLat != 0 && myLng != 0) {
          LatLng myLocation = LatLng(myLat!, myLng!);
          context.read<LocationProvider>().myLocation = myLocation;
          context.read<LocationProvider>().lastLocation = myLocation;

          Navigator.of(context)
              .pushNamedAndRemoveUntil('PageMap', (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('PageAgreement', (route) => false);
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil('PageSetLocation', (route) => false);
        }
      }

      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil('PageMap', (route) => false);
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
            '동네소식!',
            style: DSTextStyles.bold26black,
          ),
        ],
      ),
    );
  }

  Future<void> getTokenAndUserInfo(
      ModelRequestGuestInfo modelRequestUserGuestInfo) async {
    await context.read<UserProvider>().createGuest(modelRequestUserGuestInfo);
    await context.read<UserProvider>().getMe();
  }
}
