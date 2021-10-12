import 'dart:async';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/style/jcolors.dart';
import 'package:dongnesosik/global/style/jtextstyle.dart';
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
  final Map<String, Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor? customIcon;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    // Future.microtask(() {
    //   context.read<LocationProvider>().;
    // });
    getMyLocation();
  }

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/marker.png');
  }

  void getMyLocation() async {
    // final GoogleMapController controller = await _controller.future;
    Location location = new Location();

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

    context.read<LocationProvider>().setLastLocation(latlng);
    _controller.future.then((value) {
      // marker 옮기고
      final marker = Marker(
        markerId: MarkerId(latlng.toString()),
        position: latlng,
        icon: customIcon!,
      );
      _markers['dongso'] = marker;

      // 화면 옮기고
      value.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(latlng.latitude, latlng.longitude),
          zoom: 15,
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: JColors.white01,
        onPressed: () async {
          getMyLocation();
        },
      ),
    );
  }

  AppBar _appBar() {
    var provider = context.watch<LocationProvider>();
    return AppBar(
      title: Text(
          provider.placemarks.isEmpty
              ? ''
              : provider.placemarks[0].subLocality!,
          style: JTextStyle.bold18black01),
    );
  }

  Widget _body() {
    return Consumer(builder: (_, LocationProvider value, child) {
      if (value.lastLocation == null) {
        return Center(child: CircularProgressIndicator());
      } else {
        LatLng _lastLocation = value.lastLocation!;
        return GoogleMap(
            onMapCreated: (controller) async {
              await _onMapCreated(controller, _lastLocation);
            },
            initialCameraPosition: CameraPosition(
              target: _lastLocation,
              zoom: 15,
            ),
            markers: _markers.values.toSet(),
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onTap: (point) {
              _handleTap(point);
            });
      }
    });
  }

  Future<void> _onMapCreated(
      GoogleMapController controller, LatLng location) async {
    var provider = context.read<LocationProvider>();
    _markers.clear();

    print('onMapCreate');
    print(location.toString());
    final marker = Marker(
      markerId: MarkerId(location.toString()),
      position: location,
      icon: customIcon!,
    );
    _markers['dongso'] = marker;
    _controller.complete(controller);
    setState(() {
      provider.getAddress(location);
    });
  }

  _handleTap(LatLng point) {
    var provider = context.read<LocationProvider>();
    _markers.clear();
    print('handelTap');
    provider.setLastLocation(point);
    provider.getAddress(point);

    final marker = Marker(
      markerId: MarkerId(provider.lastLocation.toString()),
      position: provider.lastLocation!,

      // TODO : Info Window는 내 주변 일정거리 안에 글의 갯수를 긁어서 보여주게 함.

      icon: customIcon!,
    );
    _markers['dongso'] = marker;
  }
}
