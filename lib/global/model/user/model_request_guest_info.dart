import 'dart:convert';

class ModelRequestGuestInfo {
  String? uid;
  String? osType;
  String? osVersion;
  String? deviceModel;
  ModelRequestGuestInfo({
    this.uid,
    this.osType,
    this.osVersion,
    this.deviceModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'osType': osType,
      'osVersion': osVersion,
      'deviceModel': deviceModel,
    };
  }

  factory ModelRequestGuestInfo.fromMap(Map<String, dynamic> map) {
    return ModelRequestGuestInfo(
      uid: map['uid'] != null ? map['uid'] : null,
      osType: map['osType'] != null ? map['osType'] : null,
      osVersion: map['osVersion'] != null ? map['osVersion'] : null,
      deviceModel: map['deviceModel'] != null ? map['deviceModel'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestGuestInfo.fromJson(String source) =>
      ModelRequestGuestInfo.fromMap(json.decode(source));
}
