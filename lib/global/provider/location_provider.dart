import 'dart:io';

import 'package:dongnesosik/global/model/model_config.dart';
import 'package:dongnesosik/global/model/pin/model_request_create_pin.dart';
import 'package:dongnesosik/global/model/pin/model_request_get_pin_range.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/provider/parent_provider.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider extends ParentProvider {
  LatLng? lastLocation;
  LatLng? myLocation;
  LatLng? myPostLocation;
  String? lastAddress = '';
  List<Placemark> placemarks = [];

  List<ResponseGetPinData>? responseGetPinData = [];
  ResponseGetPinData? selectedPinData;

  setMyLocation(LatLng location) {
    myLocation = location;
    notifyListeners();
  }

  setLastLocation(LatLng location) {
    lastLocation = location;
    notifyListeners();
  }

  setMyPostLocation(LatLng location) {
    myPostLocation = location;
    notifyListeners();
  }

  Future<void> getAddress(LatLng location) async {
    try {
      placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);

      notifyListeners();
    } catch (error) {}
  }

  Future<void> createPin(ModelRequestCreatePin requestCreatePin) async {
    try {
      var api = ApiService();
      var response = await api.post('/pin/create', requestCreatePin.toMap());
      // responseGetPinData = ResponseGetPin.fromMap(response).data;

      notifyListeners();
    } catch (error) {
      setStateError();
    }
  }

  Future<void> getPinInRagne(double? lat, double? lng, int? range) async {
    try {
      ModelRequestGetPinRange requestPinGetRange =
          ModelRequestGetPinRange(lat: lat, lng: lng, range: range);
      var api = ApiService();
      var response =
          await api.post('/pin/get/range', requestPinGetRange.toMap());
      responseGetPinData = ModelResponseGetPin.fromMap(response).data;

      notifyListeners();
    } catch (error) {
      setStateError();
    }
  }

  Future<void> getPinAll() async {
    try {
      var api = ApiService();
      var response = await api.get('/pin/all');
      responseGetPinData = ModelResponseGetPin.fromMap(response).data;

      notifyListeners();
    } catch (error) {
      setStateError();
    }
  }
}