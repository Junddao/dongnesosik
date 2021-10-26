import 'package:shared_preferences/shared_preferences.dart';

class ModelSharedPreference {
  //Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  //SharedPreferences sharedPreferences = await prefs;

  static final ModelSharedPreference _manager =
      ModelSharedPreference._internal();
  factory ModelSharedPreference() {
    return _manager;
  }

  ModelSharedPreference._internal() {}

  static const String TOKEN_TYPE = 'tokenType';
  static const String TOKEN = 'token';
  //static const String GREETER_TOKEN_TYPE = 'greeterTokenType';
  //static const String GREETER_TOKEN = 'greeterToken';
  //static const String PREF_KEY_FCM_TOKEN = 'fcmToken';

  //static const String USERNAME = 'username';
  //static const String FULLNAME = 'fullname';
  //static const String USER_MOBILE = 'userMobile';
  //static const String USER_EMAIL = 'userEmail';
  //static const String USER_ENABLED = 'userEnabled';
  //static const String USER_SELECTIVE = 'userSelective';
  static const String SNS_TYPE = 'snsType';
  static const String SNS_ID = 'snsId';

  //static const String FIRST_RUN = 'firstRun';
  //static const String NOTIFICATION_CONFIRMED = 'notificationConfirmed';

  String _tokenType = '';
  String _token = '';

  String _snsType = '';
  String _snsId = '';
  //String _fcmToken = '';
  //String _username = '';
  //String _fullName = '';
  //String _userMobile = '';
  //String _userEmail = '';
  //bool _userEnabled = false;
  //bool _userSelective = false;
  //String _type = '';
  //String _fileName = '';
  //String _firstRun = '';
  //String _notificationConfirmed = '';
  String _qrCode = '';

  String get tokenType => _tokenType;
  String get token => _token;

  String get snsType => _snsType;
  String get snsId => _snsId;
  //String get fcmToken => _fcmToken;
  //String get username => _username;
  //String get fullName => _fullName;
  //String get userMobile => _userMobile;
  //String get userEmail => _userEmail;
  //bool get userEnabled => _userEnabled;
  //bool get userSelective => _userSelective;
  //String get type => _type;
  //String get fileName => _fileName;
  //String get firstRun => _firstRun;
  //String get notificationConfirmed => _notificationConfirmed;

  void clear(SharedPreferences? sharedPreferences) {
    _snsType = '';
    _snsId = '';
    _tokenType = '';
    _token = '';
    sharedPreferences?.clear();
  }

  String readToken(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(TOKEN)) {
      _token = sharedPreferences.getString(TOKEN)!;
      print(_token);
      return _token;
    }
    _token = '';
    return _token;
  }

  void writeToken(SharedPreferences? sharedPreferences, String token) {
    _token = token;
    sharedPreferences?.setString(TOKEN, _token);
  }

  void removeToken(SharedPreferences? sharedPreferences) {
    _token = '';
    if (sharedPreferences!.containsKey(TOKEN)) {
      sharedPreferences.remove(TOKEN);
    }
  }

  String readTokenType(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(TOKEN_TYPE)) {
      _tokenType = sharedPreferences.getString(TOKEN_TYPE)!;
      print(_tokenType);
      return _tokenType;
    }
    _tokenType = '';
    return _tokenType;
  }

  void writeTokenType(SharedPreferences? sharedPreferences, String tokenType) {
    _tokenType = tokenType;
    sharedPreferences?.setString(TOKEN_TYPE, _tokenType);
  }

  void removeTokenType(SharedPreferences? sharedPreferences) {
    _tokenType = '';
    if (sharedPreferences!.containsKey(TOKEN_TYPE)) {
      sharedPreferences.remove(TOKEN_TYPE);
    }
  }

  String readSnsType(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(SNS_TYPE)) {
      _snsType = sharedPreferences.getString(SNS_TYPE)!;
      print(_snsType);
      return _snsType;
    }
    _snsType = '';
    return _snsType;
  }

  void writeSnsType(SharedPreferences? sharedPreferences, String snsType) {
    _snsType = snsType;
    sharedPreferences?.setString(SNS_TYPE, _snsType);
  }

  void removeSnsType(SharedPreferences? sharedPreferences) {
    _snsType = '';
    if (sharedPreferences!.containsKey(SNS_TYPE)) {
      sharedPreferences.remove(SNS_TYPE);
    }
  }

  String readSnsId(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(SNS_ID)) {
      _snsId = sharedPreferences.getString(SNS_ID)!;
      print(_snsId);
      return _snsId;
    }
    _snsId = '';
    return _snsId;
  }

  void writeSnsId(SharedPreferences? sharedPreferences, String snsId) {
    _snsId = snsId;
    sharedPreferences!.setString(SNS_ID, _snsId);
  }

  void removeSnsId(SharedPreferences? sharedPreferences) {
    _snsId = '';
    if (sharedPreferences!.containsKey(SNS_ID)) {
      sharedPreferences.remove(SNS_ID);
    }
  }

  /*
  String readType(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey('type')) {
      _type = sharedPreferences.getString('type')!;
      print(_type);
      return _type;
    }
    _type = '';
    return _type;
  }

  void writeType(SharedPreferences? sharedPreferences, String type) {
    _type = type;
    sharedPreferences?.setString('type', _type);
  }

  String readUserName(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(USERNAME)) {
      _username = sharedPreferences.getString(USERNAME)!;
      print(_username);
      return _username;
    }
    _username = '';
    return _username;
  }

  void writeUserName(SharedPreferences? sharedPreferences, String username) {
    _username = username;
    sharedPreferences!.setString(USERNAME, _username);
  }

  String readFullName(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(FULLNAME)) {
      _fullName = sharedPreferences.getString(FULLNAME)!;
      print(_fullName);
      return _fullName;
    }
    _fullName = '';
    return _fullName;
  }

  void writeFullName(SharedPreferences? sharedPreferences, String fullName) {
    _fullName = fullName;
    sharedPreferences?.setString(FULLNAME, _fullName);
  }

  String readFileName(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey('filename')) {
      _fileName = sharedPreferences.getString('filename')!;
      print(_fileName);
      return _fileName;
    }
    _fileName = '';
    return _fileName;
  }

  void writeFileName(SharedPreferences? sharedPreferences, String fileName) {
    _fileName = fileName;
    sharedPreferences!.setString('filename', _fileName);
  }

  String readUserEmail(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(USER_EMAIL)) {
      _userEmail = sharedPreferences.getString(USER_EMAIL)!;
      print(_userEmail);
      return _userEmail;
    }
    _userEmail = '';
    return _userEmail;
  }

  void writeUserEmail(SharedPreferences? sharedPreferences, String userEmail) {
    _userEmail = userEmail;
    sharedPreferences!.setString(USER_EMAIL, _userEmail);
  }

  String readUserMobile(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(USER_MOBILE)) {
      _userMobile = sharedPreferences.getString(USER_MOBILE)!;
      print(_userMobile);
      return _userMobile;
    }
    _userMobile = '';
    return _userMobile;
  }

  void writeUserMobile(
      SharedPreferences? sharedPreferences, String userMobile) {
    _userMobile = userMobile;
    sharedPreferences!.setString(USER_MOBILE, _userMobile);
  }

  bool readUserEnabled(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(USER_ENABLED)) {
      _userEnabled = sharedPreferences.getBool(USER_ENABLED)!;
      print(_userEnabled);
      return _userEnabled;
    }
    _userEnabled = false;
    return _userEnabled;
  }

  void writeUserEnabled(SharedPreferences sharedPreferences, bool userEnabled) {
    _userEnabled = userEnabled;
    sharedPreferences.setBool(USER_ENABLED, _userEnabled);
  }

  bool readUserSelective(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(USER_SELECTIVE)) {
      _userSelective = sharedPreferences.getBool(USER_SELECTIVE)!;
      print(_userSelective);
      return _userSelective;
    }

    _userSelective = false;
    return _userSelective;
  }

  void writeUserSelective(
      SharedPreferences? sharedPreferences, bool userSelective) {
    _userSelective = userSelective;
    sharedPreferences!.setBool(USER_SELECTIVE, _userSelective);
  }

  String readGreeterTokenType(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(GREETER_TOKEN_TYPE)) {
      _greeterTokenType = sharedPreferences.getString(GREETER_TOKEN_TYPE)!;
      print(_greeterTokenType);
      return _greeterTokenType;
    }
    _greeterTokenType = '';
    return _greeterTokenType;
  }

  void writeGreeterTokenType(
      SharedPreferences? sharedPreferences, String greeterTokenType) {
    _greeterTokenType = greeterTokenType;
    sharedPreferences!.setString(GREETER_TOKEN_TYPE, _greeterTokenType);
  }

  String readGreeterToken(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(GREETER_TOKEN)) {
      _greeterToken = sharedPreferences.getString(GREETER_TOKEN)!;
      print(_greeterToken);
      return _greeterToken;
    }
    _greeterToken = '';
    return _greeterToken;
  }

  void writeGreeterToken(
      SharedPreferences? sharedPreferences, String greeterToken) {
    _greeterToken = greeterToken;
    sharedPreferences!.setString(GREETER_TOKEN, _greeterToken);
  }

  String readFcmToken(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(PREF_KEY_FCM_TOKEN)) {
      _fcmToken = sharedPreferences.getString(PREF_KEY_FCM_TOKEN)!;
      print(_fcmToken);
      return _fcmToken;
    }
    _fcmToken = '';
    return _fcmToken;
  }

  void writeFcmToken(SharedPreferences? sharedPreferences, String fcmToken) {
    _fcmToken = fcmToken;
    sharedPreferences!.setString(PREF_KEY_FCM_TOKEN, _fcmToken);
  }

  String readFirstRun(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(FIRST_RUN)) {
      _firstRun = sharedPreferences.getString(FIRST_RUN)!;
      print(_firstRun);
      return _firstRun;
    }
    _firstRun = '';
    return _firstRun;
  }

  void writeFirstRun(SharedPreferences? sharedPreferences, String firstRun) {
    _firstRun = firstRun;
    sharedPreferences!.setString(FIRST_RUN, _firstRun);
  }

  String readNotificationConfirmed(SharedPreferences? sharedPreferences) {
    if (sharedPreferences!.containsKey(NOTIFICATION_CONFIRMED)) {
      _notificationConfirmed =
          sharedPreferences.getString(NOTIFICATION_CONFIRMED)!;
      print(_notificationConfirmed);
      return _notificationConfirmed;
    }
    _notificationConfirmed = '';
    return _notificationConfirmed;
  }

  void writeNotificationConfirmed(
      SharedPreferences? sharedPreferences, String notificationConfirmed) {
    _notificationConfirmed = notificationConfirmed;
    sharedPreferences!
        .setString(NOTIFICATION_CONFIRMED, _notificationConfirmed);
  }
   */
}
