import 'package:dongnesosik/global/model/user/model_response_user_get.dart';
import 'package:dongnesosik/global/model/user/model_user_info.dart';

class SingletonUser {
  static final singletonUser = SingletonUser();

  ModelUserInfo userData = ModelUserInfo();

  Future<void> setUser(ModelUserInfo userData) async {
    SingletonUser.singletonUser.userData = userData;
  }
}
