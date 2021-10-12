class ConfigModel {
  static final ConfigModel _manager = ConfigModel._internal();
  factory ConfigModel() {
    return _manager;
  }
  ConfigModel._internal();

  String apiProjectName = '';
  String serverCurruntType = '';
  String serverBaseUrl = '';
  String termUrl = '';
  String privatePolicyUrl = '';
  String thirdPartyPrivatePolicyUrl = '';
  String kakaoSdkApiKey = '';
  String webSocketServer = '';
  String googleReverseGeocodingRequest = '';
  String iosGoogleApiKey = '';
  String andGoogleApiKey = '';

  void fromJson(Map<String, dynamic> json) {
    apiProjectName = json['api_project_name'];
    print('ApiProjectName : $apiProjectName');

    serverCurruntType = json['server_current_type'];
    print('serverCurrentType : $serverCurruntType');

    termUrl = json['terms_url'];
    print('terms_url : $termUrl');

    privatePolicyUrl = json['privacy_policy_url'];
    print('privacy_policy_url : $privatePolicyUrl');

    thirdPartyPrivatePolicyUrl = json['third_party_policy_url'];
    print('third_party_policy_url : $thirdPartyPrivatePolicyUrl');

    iosGoogleApiKey = json['ios_google_api_key'];
    print('iosGoogleApiKey : $iosGoogleApiKey');

    andGoogleApiKey = json['and_google_api_key'];
    print('andGoogleApiKey : $andGoogleApiKey');

    googleReverseGeocodingRequest = json['google_reverse_geocoding_request'];
    print('googleReverseGeocodingRequest : $googleReverseGeocodingRequest');

    final serverInfoList = List.from(json['server_info']);
    print('serverInfoList : ${serverInfoList}');

    for (var countIndex = 0; countIndex < serverInfoList.length; ++countIndex) {
      final serverType = serverInfoList[countIndex]['type'];
      print('ServerType : $serverType');

      if (0 == serverCurruntType.compareTo(serverType)) {
        serverBaseUrl = serverInfoList[countIndex]['base_url'];
        print('countIndex : $countIndex');

        webSocketServer = serverInfoList[countIndex]['websocket_server'];
        print('websocket_server : $webSocketServer');
      }
    }
  }
}
