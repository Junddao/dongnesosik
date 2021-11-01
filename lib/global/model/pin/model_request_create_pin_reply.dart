import 'dart:convert';

class ModelRequestCreatePinReply {
  int? pinId;
  String? body;
  String? password;
  ModelRequestCreatePinReply({
    this.pinId,
    this.body,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'pinId': pinId,
      'body': body,
      'password': password,
    };
  }

  factory ModelRequestCreatePinReply.fromMap(Map<String, dynamic> map) {
    return ModelRequestCreatePinReply(
      pinId: map['pinId'] != null ? map['pinId'] : null,
      body: map['body'] != null ? map['body'] : null,
      password: map['password'] != null ? map['password'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestCreatePinReply.fromJson(String source) =>
      ModelRequestCreatePinReply.fromMap(json.decode(source));
}
