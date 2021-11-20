import 'dart:io';

import 'package:dongnesosik/global/model/model_config.dart';
import 'package:dongnesosik/global/model/pin/model_request_create_pin.dart';
import 'package:dongnesosik/global/model/pin/model_request_create_pin_reply.dart';
import 'package:dongnesosik/global/model/pin/model_request_get_pin_range.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin_reply.dart';
import 'package:dongnesosik/global/provider/parent_provider.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:dongnesosik/global/util/date_converter.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider extends ParentProvider {
  LatLng? lastLocation;
  LatLng? myLocation;
  LatLng? myPostLocation;

  String? lastAddress = '';
  String? myAddress = '';
  List<Placemark> placemarks = [];

  List<ResponseGetPinData>? responseGetPinDatas = [];
  List<ResponseGetPinData>? myPinDatas = [];
  List<ResponseGetPinData>? top50PinDatas = [];
  ResponseGetPinData? selectedPinData;
  int? selectedId;

  List<ModelResponseGetPinReplyData>? responseGetPinReplyData = [];

  ModelResponseGetPinReplyData? selectedReplyData;

  setMyAddress(String? address) {
    myAddress = address;
    notifyListeners();
  }

  void setReplyTarget(ModelResponseGetPinReplyData? _selectedReplyData) {
    selectedReplyData = _selectedReplyData;
    notifyListeners();
  }

  setMyLocation(LatLng location) {
    double lat = DataConvert.roundDouble(location.latitude, 6);
    double lng = DataConvert.roundDouble(location.longitude, 6);
    LatLng _location = LatLng(lat, lng);
    myLocation = _location;
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
      //geocoding
      placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);

      // google_geocoding
      // double lat = DataConvert.roundDouble(location.latitude, 6);
      // double lng = DataConvert.roundDouble(location.longitude, 6);
      // var googleGeocoding =
      //     GoogleGeocoding("AIzaSyAoeKpyN_EODABnnIV_Wdx7Tu8Y1QECowY");
      // var risult = await googleGeocoding.geocoding.getReverse(LatLon(lat, lng));

      notifyListeners();
    } catch (error) {
      print(error);
    }
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

  Future<void> deleteReply(int id) async {
    try {
      setStateBusy();
      var api = ApiService();
      var response = await api.get('/pin/delete/reply/$id');

      setStateIdle();
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
      var api = ApiService();
      var response = await api.get('/pin/like/$id');

      notifyListeners();
    } catch (error) {
      // setStateError();
      throw Exception();
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

  // Future<void> getAddressByGoogle(LatLng location) async {
  //   double lat = DataConvert.roundDouble(location.latitude, 6);
  //   double lng = DataConvert.roundDouble(location.longitude, 6);

  //   String _path = 'latlng=$lat,$lng';

  //   var api = ApiService();
  //   var response = await api.getGoogleGeoApi(_path);

  //   // https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=
  // }
}
