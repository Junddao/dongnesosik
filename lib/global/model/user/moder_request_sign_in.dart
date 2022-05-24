import 'dart:convert';

class ModelReqeustSignIn {
  String? firebaseIdToken;
  String? uid;
  String? osType;
  String? osVersion;
  String? deviceModel;
  ModelReqeustSignIn({
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

  factory ModelReqeustSignIn.fromMap(Map<String, dynamic> map) {
    return ModelReqeustSignIn(
      firebaseIdToken: map['firebaseIdToken'],
      uid: map['uid'],
      osType: map['osType'],
      osVersion: map['osVersion'],
      deviceModel: map['deviceModel'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelReqeustSignIn.fromJson(String source) =>
      ModelReqeustSignIn.fromMap(json.decode(source));
}
