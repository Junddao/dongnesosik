import 'dart:async';
import 'package:dongnesosik/global/model/pin/response_get_pin.dart';
import 'package:dongnesosik/global/provider/maps/location_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyle.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class PageMap extends StatefulWidget {
  const PageMap({Key? key}) : super(key: key);

  @override
  _PageMapState createState() => _PageMapState();
}

class _PageMapState extends State<PageMap> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Marker> _markers = [];
  Completer<GoogleMapController> _controller = Completer();
  Location location = Location();

  BitmapDescriptor? customIcon;

  @override
  void initState() {
    super.initState();
    getMyLocation();
  }

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/images/marker.png',
    );
  }

  void getMyLocation() async {
    // final GoogleMapController controller = await _controller.future;
    if (context.read<LocationProvider>().myLocation != null) {
      moveCameraToMyLocation();
      return;
    }

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location services are disabled.');
      }
    }

    LocationData locationData = await location.getLocation();
    print(locationData.latitude!);
    print(locationData.longitude!);
    LatLng latlng = LatLng(locationData.latitude!, locationData.longitude!);

    context.read<LocationProvider>().setMyLocation(latlng);
    context.read<LocationProvider>().setLastLocation(latlng);
    moveCameraToMyLocation();
  }

  void moveCameraToMyLocation() {
    var provider = context.read<LocationProvider>();
    _controller.future.then((value) {
      value.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(
              provider.myLocation!.latitude, provider.myLocation!.longitude),
          zoom: 15,
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(),
        body: _body(),
        drawer: _drawer(),
        extendBodyBehindAppBar: true,
        drawerEnableOpenDragGesture: true,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: DSColors.white),

          // child: Text('글쓰기', style: DSTextStyle.bold12Black),
          backgroundColor: DSColors.tomato,
          onPressed: () async {
            Navigator.of(context).pushNamed('PagePostCreate');
          },
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  AppBar _appBar() {
    var provider = context.watch<LocationProvider>();
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: Text(
          provider.placemarks.isEmpty
              ? ''
              : provider.placemarks[0].subLocality!,
          style: DSTextStyle.bold18Black),
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       Navigator.of(context).pushNamed('PageUserSetting');
      //     },
      //     icon: Icon(
      //       Icons.person,
      //     ),
      //   ),
      // ],
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(left: 10),
        children: <Widget>[
          // drawer header
          _drawerHeader(),

          // my history

          ListTile(
            leading:
                Image.asset('assets/images/marker1.png', fit: BoxFit.cover),
            title: Text(
              'aaa',
              style: DSTextStyle.bold18Grey06,
            ),
            onTap: () {
              Navigator.of(context).pop(); // drawer 닫기
            },
          ),
          ListTile(
            leading:
                Image.asset('assets/images/marker1.png', fit: BoxFit.cover),
            title: Text(
              'bbb',
              style: DSTextStyle.bold18Grey06,
            ),
            onTap: () {
              Navigator.of(context).pop(); // drawer 닫기
            },
          ),
        ],
      ),
    );
    // Disable opening the drawer with a swipe gesture.
  }

  Widget _body() {
    return Consumer(builder: (_, LocationProvider value, child) {
      if (value.lastLocation == null || value.responseGetPinData == null) {
        return Center(child: CircularProgressIndicator());
      } else {
        LatLng _lastLocation = value.lastLocation!;
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) async {
                await _onMapCreated(controller, _lastLocation);
              },
              initialCameraPosition: CameraPosition(
                target: _lastLocation,
                zoom: 15,
              ),
              markers: _markers.toSet(),
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              onCameraMove: _onCameraMove,
              onCameraIdle: _onCameraIdle,
              // onTap: (point) {
              //   _handleTap(point);
              // },
            ),
            Positioned(
              bottom: 30,
              left: 24,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('PagePost');
                  },
                  child: _newsInfoWidget()),
            ),
            Positioned(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  30,
              right: 12,
              child: InkWell(
                onTap: () async {
                  getMyLocation();
                },
                child: CircleAvatar(
                  backgroundColor: DSColors.white,
                  foregroundColor: DSColors.black,
                  child: Icon(Icons.my_location),
                ),
              ),
            ),
          ],
        );
      }
    });
  }

  Container _drawerHeader() {
    return Container(
      // height: 300,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
        child: Column(
          children: [
            ListTile(
              title: Text('memil님', style: DSTextStyle.bold16Black),
              subtitle: Text('반갑습니다.', style: DSTextStyle.regular12WarmGrey),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).pushNamed('PageUserSetting');
              },
            ),
            // Divider(),
          ],
        ),
      ),
    );
  }

  addMyPin() {
    var provider = context.read<LocationProvider>();
    _markers.clear();
    addMarker(0, provider.lastLocation!);
  }

  Future<void> _onMapCreated(
      GoogleMapController controller, LatLng location) async {
    _markers.clear();
    var provider = context.read<LocationProvider>();

    print('onMapCreate');
    print(location.toString());
    addMarker(0, location);

    _controller.complete(controller);
    provider.getAddress(location);
  }

  void _onCameraIdle() async {
    _markers.clear();
    var provider = context.read<LocationProvider>();

    // addMyPin();
    await provider.getPinInRagne(provider.lastLocation!.latitude,
        provider.lastLocation!.longitude, 1000);
    provider.responseGetPinData!.forEach((element) {
      addMarker(element.id!, LatLng(element.pin!.lat!, element.pin!.lng!));
    });

    // await provider.getPinAll();
    print("Idle");
  }

  void _onCameraMove(CameraPosition position) {
    var provider = context.read<LocationProvider>();
    provider.setLastLocation(position.target);
    print("move");
  }

  void addMarker(int id, LatLng latLng) {
    final marker = Marker(
        markerId: MarkerId(id.toString()),
        position: latLng,
        // icon: customIcon!,

        onTap: () async {
          print('marker onTap()');

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return buildBottomSheet(context, id);
            },
          );
        });
    _markers.add(marker);
  }

//   _handleTap(LatLng point) {

//     var provider = context.read<LocationProvider>();

//     print('handelTap');
//     provider.setLastLocation(point);
//     provider.getAddress(point);

// _markers.clear();
// addMarker(id, latLng)
//     final marker = Marker(
//       markerId: MarkerId(provider.lastLocation.toString()),
//       position: provider.lastLocation!,

//       // TODO : Info Window는 내 주변 일정거리 안에 글의 갯수를 긁어서 보여주게 함.

//       // icon: customIcon!,
//     );

//     _markers.add(marker);
//   }

  Widget _newsInfoWidget() {
    var provider = context.read<LocationProvider>();
    return provider.responseGetPinData!.length == 0
        ? SizedBox.shrink()
        : InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('PagePost');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: DSColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              // width: SizeConfig.screenWidth * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '게시글', style: DSTextStyle.bold14Black),
                        TextSpan(
                            text: ' (${provider.responseGetPinData!.length}개)',
                            style: DSTextStyle.regular12Black),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    // provider.responseGetPinData!.first.pin!.title!,
                    '목록 보기',
                    style: DSTextStyle.regular14Black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
  }

  Widget buildBottomSheet(BuildContext context, int id) {
    var responseGetPinDatas =
        context.read<LocationProvider>().responseGetPinData!.where((element) {
      return element.id == id;
    }).toList();
    context.read<LocationProvider>().selectedPinData =
        responseGetPinDatas.first;
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
            InkWell(
              onTap: () {
                goDetailPage();
              },
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(responseGetPinDatas.first.pin!.title!,
                        style: DSTextStyle.bold16Black),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      responseGetPinDatas.first.pin!.body!,
                      style: DSTextStyle.regular12Black,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            DSButton(
              text: '대화방 보기',
              width: SizeConfig.screenWidth,
              press: () {
                goCommunityPage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void goDetailPage() async {
    Navigator.of(context).pushNamed('PagePostDetail');
  }

  void goCommunityPage() async {
    Navigator.of(context).pushNamed('PagePostCommunity');
  }

  void onClosePress() async {
    Navigator.of(context).pop();
  }
}
