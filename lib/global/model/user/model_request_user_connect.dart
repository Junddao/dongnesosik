import 'dart:convert';

class ModelReqeustUserConnect {
  String? firebaseIdToken;
  String? uid;
  String? osType;
  String? osVersion;
  String? deviceModel;
  ModelReqeustUserConnect({
    this.firebaseIdToken,
    this.uid,
    this.osType,
    this.osVersion,
    this.deviceModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'firebaseIdToken': firebaseIdToken,
      'uid': uid,
      'osType': osType,
      'osVersion': osVersion,
      'deviceModel': deviceModel,
    };
  }

  factory ModelReqeustUserConnect.fromMap(Map<String, dynamic> map) {
    return ModelReqeustUserConnect(
      firebaseIdToken:
          map['firebaseIdToken'] != null ? map['firebaseIdToken'] : null,
      uid: map['uid'] != null ? map['uid'] : null,
      osType: map['osType'] != null ? map['osType'] : null,
      osVersion: map['osVersion'] != null ? map['osVersion'] : null,
      deviceModel: map['deviceModel'] != null ? map['deviceModel'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelReqeustUserConnect.fromJson(String source) =>
      ModelReqeustUserConnect.fromMap(json.decode(source));
}
