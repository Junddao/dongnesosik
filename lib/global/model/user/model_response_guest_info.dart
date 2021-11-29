import 'dart:convert';

class ModelResponseGuestInfo {
  ModelGuestInfoData? data;
  ModelResponseGuestInfo({
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data?.toMap(),
    };
  }

  factory ModelResponseGuestInfo.fromMap(Map<String, dynamic> map) {
    return ModelResponseGuestInfo(
      data:
          map['data'] != null ? ModelGuestInfoData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGuestInfo.fromJson(String source) =>
      ModelResponseGuestInfo.fromMap(json.decode(source));
}

class ModelGuestInfoData {
  String? accessToken;
  int? userId;
  ModelGuestInfoData({
    this.accessToken,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'userId': userId,
    };
  }

  factory ModelGuestInfoData.fromMap(Map<String, dynamic> map) {
    return ModelGuestInfoData(
      accessToken: map['accessToken'] != null ? map['accessToken'] : null,
      userId: map['userId'] != null ? map['userId'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelGuestInfoData.fromJson(String source) =>
      ModelGuestInfoData.fromMap(json.decode(source));
}
