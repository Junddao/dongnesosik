import 'package:dongnesosik/global/model/model_shared_preferences.dart';
import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/model/user/model_request_guest_info.dart';
import 'package:dongnesosik/global/model/user/model_request_user_connect.dart';
import 'package:dongnesosik/global/model/user/model_request_user_set.dart';
import 'package:dongnesosik/global/model/user/model_response_guest_info.dart';
import 'package:dongnesosik/global/model/user/model_response_user_get.dart';
import 'package:dongnesosik/global/model/user/model_user_info.dart';

import 'package:dongnesosik/global/provider/parent_provider.dart';
import 'package:dongnesosik/global/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ParentProvider {
  Future<void> createGuest(
      ModelRequestGuestInfo modelRequestUserGuestInfo) async {
    try {
      var api = ApiService();
      var response = await api.postWithOutToken(
          '/user/create/guest', modelRequestUserGuestInfo.toMap());
      ModelResponseGuestInfo responseUserGuestInfo =
          ModelResponseGuestInfo.fromMap(response);
      ModelGuestInfoData modelUserGuestInfoData = responseUserGuestInfo.data!;

      // shared에 때려박기
      ModelSharedPreferences.writeToken(modelUserGuestInfoData.accessToken!);

      // responseGetPinData = ResponseGetPin.fromMap(response).data;

      notifyListeners();
    } catch (error) {
      setStateError();
    }
  }

  Future<void> getUser() async {
    try {
      setStateBusy();
      var api = ApiService();

      var response = await api.get('/user/get');
      ModelResponseUserGet modelResponseUserGet =
          ModelResponseUserGet.fromMap(response);
      ModelResponseUserGetData modelResponseUserGetData =
          modelResponseUserGet.data!;

      // user factory 에 정보 때려박기
      ModelUserInfo modelUserInfo =
          ModelUserInfo.fromMap(modelResponseUserGetData.toMap());
      SingletonUser.singletonUser.setUser(modelUserInfo);

      setStateIdle();
    } catch (error) {
      setStateError();
      throw Exception();
    }

    // return userResponse!.data;
  }

  Future<void> setUser(ModelRequestUserSet modelRequestUserSet) async {
    try {
      setStateBusy();
      var api = ApiService();

      var response = await api.post('/user/set', modelRequestUserSet.toMap());

      // user factory 에 정보 때려박기
      ModelUserInfo modelUserInfo =
          ModelUserInfo.fromMap(modelRequestUserSet.toMap());
      modelUserInfo.id = SingletonUser.singletonUser.userData.id;
      SingletonUser.singletonUser.setUser(modelUserInfo);

      setStateIdle();
    } catch (error) {
      setStateError();
      throw Exception();
    }
  }

  Future<void> userConnect(
      ModelReqeustUserConnect modelReqeustUserConnect) async {
    try {
      setStateBusy();
      var api = ApiService();

      var response =
          await api.post('/user/connect', modelReqeustUserConnect.toMap());

      setStateIdle();
    } catch (error) {
      setStateError();
      throw Exception();
    }
  }
}
