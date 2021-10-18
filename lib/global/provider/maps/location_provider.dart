import 'dart:io';

import 'package:dongnesosik/global/model/config_model.dart';
import 'package:dongnesosik/global/model/pin/request_get_pin_range.dart';
import 'package:dongnesosik/global/model/pin/response_get_pin.dart';
import 'package:dongnesosik/global/provider/parent_provider.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider extends ParentProvider {
  LatLng? lastLocation;
  String? lastAddress = '';
  List<Placemark> placemarks = [];

  List<ResponseGetPinData>? responseGetPinRangeData = [];
  List<ResponseGetPinData>? responseGetPinAllData = [];

  setLastLocation(LatLng location) {
    lastLocation = location;
    notifyListeners();
  }

  Future<void> getAddress(LatLng location) async {
    try {
      placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);

      notifyListeners();
    } catch (error) {}
  }

  Future<void> getPinInRagne(double? lat, double? lng, int? range) async {
    try {
      RequestGetPinRange requestPinGetRange =
          RequestGetPinRange(lat: lat, lng: lng, range: range);
      var api = ApiService();
      var response =
          await api.post('/pin/get/range', requestPinGetRange.toMap());
      responseGetPinRangeData = ResponseGetPin.fromMap(response).data;

      notifyListeners();
    } catch (error) {
      setStateError();
    }
  }

  Future<void> getPinAll() async {
    try {
      var api = ApiService();
      var response = await api.get('/pin/all');
      responseGetPinAllData = ResponseGetPin.fromMap(response).data;

      notifyListeners();
    } catch (error) {
      setStateError();
    }
  }
}
