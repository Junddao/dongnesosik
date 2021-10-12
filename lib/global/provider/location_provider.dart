import 'dart:io';

import 'package:dongnesosik/global/model/config_model.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider extends ChangeNotifier {
  LatLng? lastLocation;
  String? lastAddress = '';
  List<Placemark> placemarks = [];

  setLastLocation(LatLng location) {
    lastLocation = location;
    notifyListeners();
  }

  Future<void> getAddress(LatLng location) async {
    try {
      placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      // String apiKey = '';

      // if (Platform.isAndroid) {
      //   apiKey = ConfigModel().andGoogleApiKey;
      // } else {
      //   apiKey = ConfigModel().iosGoogleApiKey;
      // }

      // var api = ApiService();
      // var response = await api.getGoogleGeoApi(
      //     '${ConfigModel().googleReverseGeocodingRequest}latlng=${location.latitude},${location.longitude}&key=$apiKey');
      // lastAddress = response['result'][0]['formatted_address'];

      notifyListeners();
    } catch (error) {}
  }
}
