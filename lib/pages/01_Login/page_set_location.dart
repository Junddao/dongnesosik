import 'package:dongnesosik/global/model/model_shared_preferences.dart';
import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/model/user/model_request_user_set.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/provider/user_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';

class PageSetLocation extends StatefulWidget {
  const PageSetLocation({Key? key}) : super(key: key);

  @override
  _PageSetLocationState createState() => _PageSetLocationState();
}

class _PageSetLocationState extends State<PageSetLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      // title: Text('시작 위치 지정'),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _body() {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  'assets/images/address.svg',
                  height: SizeConfig.screenHeight * 0.4,
                ),
                SizedBox(height: 50),
                Text('주변 소식을 받을', style: DSTextStyles.bold18Black),
                SizedBox(height: 8),
                Text('위치를 선택해주세요.', style: DSTextStyles.bold18Black),
              ],
            ),
            TextButton(
              onPressed: () async {
                getAddressWidget();
              },
              child: DSButton(
                press: getAddressWidget,
                text: '주소로 위치지정',
                fontWeight: FontWeight.bold,
                width: MediaQuery.of(context).size.width -
                    kDefaultHorizontalPadding * 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getAddressWidget() async {
    Kpostal result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => KpostalView(
            kakaoKey: 'b5e7efc8dd3cfea64f13554d4fb85553',
            useLocalServer: true,
            callback: (Kpostal result) {
              print(result.address);
            },
          ),
        ));
    if (result != null) {
      LatLng? myLocation =
          LatLng(result.kakaoLatitude!, result.kakaoLongitude!);
      // if (result.latitude == null) {
      //   Location? location = await result.latLng;
      //   myLocation = LatLng(location!.latitude, location.longitude);
      // } else {
      //   myLocation = LatLng(result.latitude!, result.longitude!);
      // }

      context.read<LocationProvider>().myLocation =
          LatLng(myLocation.latitude, myLocation.longitude);
      context.read<LocationProvider>().lastLocation =
          LatLng(myLocation.latitude, myLocation.longitude);
      context.read<LocationProvider>().setMyAddress(result.address);
      print(context.read<LocationProvider>().myLocation);
      ModelSharedPreferences.writeMyLat(myLocation.latitude);
      ModelSharedPreferences.writeMyLng(myLocation.longitude);

      // user set 할것.
      SingletonUser.singletonUser.userData.address = result.address;
      ModelRequestUserSet modelRequestUserSet = ModelRequestUserSet.fromMap(
          SingletonUser.singletonUser.userData.toUserSetMap());
      context.read<UserProvider>().setUser(modelRequestUserSet);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('PageMap', (route) => false);
    }
  }
}
