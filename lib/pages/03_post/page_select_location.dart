import 'dart:async';
import 'dart:io';

import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PageSelectLocation extends StatefulWidget {
  const PageSelectLocation({Key? key}) : super(key: key);

  @override
  _PageSelectLocationState createState() => _PageSelectLocationState();
}

class _PageSelectLocationState extends State<PageSelectLocation> {
  List<Marker> _markers = [];
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController _tecAddress = TextEditingController();

  @override
  void dispose() {
    _tecAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('위치 선택'),
      centerTitle: true,
    );
  }

  _body() {
    var provider = context.watch<LocationProvider>();
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) async {
            await _onMapCreated(controller, provider);
          },
          initialCameraPosition: CameraPosition(
            target: provider.lastLocation!,
            zoom: 15,
          ),
          markers: _markers.toSet(),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          onTap: _handleTap,

          // onTap: (point) {
          //   _handleTap(point);
          // },
        ),
        // SafeArea(
        //   child: Positioned(
        //     top: 20,
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //           horizontal: kDefaultHorizontalPadding, vertical: 0),
        //       child: Container(
        //         height: 54,
        //         width: SizeConfig.screenWidth - kDefaultHorizontalPadding * 2,
        //         padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
        //         decoration: BoxDecoration(
        //           color: DSColors.white,
        //           border: Border.all(color: DSColors.black),
        //           borderRadius: BorderRadius.circular(24),
        //         ),
        //         child: TextFormField(
        //           controller: _tecAddress,
        //           decoration: InputDecoration(
        //             hintText: "주소를 입력해주세요.",
        //             hintStyle: DSTextStyles.medium16WhiteThree,
        //             labelStyle: TextStyle(color: Colors.transparent),
        //             border: UnderlineInputBorder(
        //               borderSide: BorderSide.none,
        //             ),
        //           ),
        //           validator: (text) {
        //             return text == null ? '제목을 입력해주세요.' : null;
        //           },
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Future<void> _onMapCreated(
      GoogleMapController controller, LocationProvider provider) async {
    _markers.clear();

    print('onMapCreate');
    print(provider.lastLocation.toString());

    // addMarker(0, provider.myLocation!);

    _controller.complete(controller);
  }

  void addMarker(int id, LatLng latLng) {
    final marker = Marker(
      markerId: MarkerId(id.toString()),
      position: latLng,
      // icon: customIcon!,
    );
    _markers.add(marker);
  }

  _handleTap(LatLng point) {
    var provider = context.read<LocationProvider>();

    print('handelTap');
    provider.setMyPostLocation(point);
    provider.getAddress(point);

    _markers.clear();
    addMarker(0, point);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return buildBottomSheet(context);
      },
    );
  }

  Widget buildBottomSheet(BuildContext context) {
    var provider = context.watch<LocationProvider>();
    // String? address = provider.placemarks[0].name!;
    String? address = '';
    if (Platform.isAndroid) {
      address = provider.placemarks[0].street;
    } else {
      // address = provider.placemarks[0].locality! +
      //     " " +
      //     provider.placemarks[0].subLocality! +
      //     " " +
      //     provider.placemarks[0].thoroughfare! +
      //     " " +
      //     provider.placemarks[0].subThoroughfare!;
      address = provider.placemarks[0].name!;
    }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: DSColors.white),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(address!, style: DSTextStyles.bold14Black),
            SizedBox(
              height: 10,
            ),
            Divider(),
            DSButton(
              text: '네, 이 위치로 선택할래요!',
              width: SizeConfig.screenWidth,
              press: () {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName('PagePostCreate'));
              },
            ),
            DSButton(
              text: '다시 선택할께요.',
              width: SizeConfig.screenWidth,
              type: ButtonType.transparent,
              press: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
