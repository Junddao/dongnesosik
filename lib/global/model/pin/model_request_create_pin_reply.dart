import 'dart:convert';

class ModelRequestCreatePinReply {
  int? pinId;
  String? body;

  ModelRequestCreatePinReply({
    this.pinId,
    this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'pinId': pinId,
      'body': body,
    };
  }

  factory ModelRequestCreatePinReply.fromMap(Map<String, dynamic> map) {
    return ModelRequestCreatePinReply(
      pinId: map['pinId'] != null ? map['pinId'] : null,
      body: map['body'] != null ? map['body'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestCreatePinReply.fromJson(String source) =>
      ModelRequestCreatePinReply.fromMap(json.decode(source));
}
