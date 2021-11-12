import 'dart:io';

import 'package:dongnesosik/global/model/model_config.dart';
import 'package:dongnesosik/global/model/pin/model_request_create_pin.dart';
import 'package:dongnesosik/global/model/pin/model_request_create_pin_reply.dart';
import 'package:dongnesosik/global/model/pin/model_request_get_pin_range.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin_reply.dart';
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

  List<ResponseGetPinData>? responseGetPinDatas = [];
  List<ResponseGetPinData>? myPinDatas = [];
  List<ResponseGetPinData>? top50PinDatas = [];
  ResponseGetPinData? selectedPinData;
  int? selectedId;

  List<ModelResponseGetPinReplyData>? responseGetPinReplyData = [];

  ModelResponseGetPinReplyData? selectedReplyData;

  void setReplyTarget(ModelResponseGetPinReplyData? _selectedReplyData) {
    selectedReplyData = _selectedReplyData;
    notifyListeners();
  }

  setMyLocation(LatLng location) {
    myLocation = location;
    notifyListeners();
  }

  setLastLocation(LatLng location) {
    lastLocation = location;
    notifyListeners();
  }

  setSelectedId(int? id) {
    selectedId = id;
    notifyListeners();
  }

  setSelectLocation(LatLng location) {
    lastLocation = location;
    notifyListeners();
  }

  setMyPostLocation(LatLng? location) {
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

  Future<List<ResponseGetPinData>?> getPinInRagne(
      double? lat, double? lng, int? range) async {
    try {
      ModelRequestGetPinRange requestPinGetRange =
          ModelRequestGetPinRange(lat: lat, lng: lng, range: range);
      var api = ApiService();
      var response =
          await api.post('/pin/get/range', requestPinGetRange.toMap());
      responseGetPinDatas = ModelResponseGetPin.fromMap(response).data;

      notifyListeners();
      return responseGetPinDatas;
    } catch (error) {
      setStateError();
    }
  }

  Future<void> getPinAll() async {
    try {
      var api = ApiService();
      var response = await api.get('/pin/all');
      responseGetPinDatas = ModelResponseGetPin.fromMap(response).data;

      notifyListeners();
    } catch (error) {
      setStateError();
    }
  }

  Future<void> createReply(
      ModelRequestCreatePinReply modelRequestCreatePinReply) async {
    try {
      var api = ApiService();
      var response = await api.post(
          '/pin/create/reply', modelRequestCreatePinReply.toMap());
      // responseGetPinData = ResponseGetPin.fromMap(response).data;

      notifyListeners();
    } catch (error) {
      setStateError();
    }
  }

  Future<void> getPinReply(int id) async {
    try {
      var api = ApiService();
      var response = await api.get('/pin/get/reply/$id');
      responseGetPinReplyData = ModelResponseGetPinReply.fromMap(response).data;

      notifyListeners();
    } catch (error) {
      setStateError();
    }
  }

  Future<void> getPinMe() async {
    try {
      setStateBusy();
      var api = ApiService();
      var response = await api.get('/pin/get/me');
      myPinDatas = ModelResponseGetPin.fromMap(response).data;
      setStateIdle();
      // notifyListeners();
    } catch (error) {
      setStateError();
    }
  }

  Future<void> getPinTop50() async {
    try {
      setStateBusy();
      var api = ApiService();
      var response = await api.get('/pin/get/top50');
      top50PinDatas = ModelResponseGetPin.fromMap(response).data;

      setStateIdle();
    } catch (error) {
      setStateError();
    }
  }

  Future<void> pinLikeToId(int id) async {
    try {
      setStateBusy();
      var api = ApiService();
      var response = await api.get('/pin/like/$id');

      setStateIdle();
    } catch (error) {
      setStateError();
    }
  }

  Future<void> pinDelete(int id) async {
    try {
      setStateBusy();
      var api = ApiService();
      var response = await api.get('/pin/delete/$id');

      setStateIdle();
    } catch (error) {
      setStateError();
    }
  }
}
