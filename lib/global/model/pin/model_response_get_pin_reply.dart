import 'dart:convert';

class ModelResponseGetPinReply {
  String? result;
  String? message;
  List<ModelResponseGetPinReplyData>? data;
  ModelResponseGetPinReply({
    this.result,
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelResponseGetPinReply.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetPinReply(
      result: map['result'] != null ? map['result'] : null,
      message: map['message'] != null ? map['message'] : null,
      data: map['data'] != null
          ? List<ModelResponseGetPinReplyData>.from(
              map['data']?.map((x) => ModelResponseGetPinReplyData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetPinReply.fromJson(String source) =>
      ModelResponseGetPinReply.fromMap(json.decode(source));
}

class ModelResponseGetPinReplyData {
  String? name;
  String? createAt;
  int? userId;
  ModelPinReply? reply;
  ModelResponseGetPinReplyData({
    this.name,
    this.createAt,
    this.userId,
    this.reply,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'createAt': createAt,
      'userId': userId,
      'reply': reply?.toMap(),
    };
  }

  factory ModelResponseGetPinReplyData.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetPinReplyData(
      name: map['name'] != null ? map['name'] : null,
      createAt: map['createAt'] != null ? map['createAt'] : null,
      userId: map['userId'] != null ? map['userId'] : null,
      reply: map['reply'] != null ? ModelPinReply.fromMap(map['reply']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetPinReplyData.fromJson(String source) =>
      ModelResponseGetPinReplyData.fromMap(json.decode(source));
}

class ModelPinReply {
  int? id;
  int? pinId;
  String? body;
  ModelPinReply({
    this.id,
    this.pinId,
    this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pinId': pinId,
      'body': body,
    };
  }

  factory ModelPinReply.fromMap(Map<String, dynamic> map) {
    return ModelPinReply(
      id: map['id'] != null ? map['id'] : null,
      pinId: map['pinId'] != null ? map['pinId'] : null,
      body: map['body'] != null ? map['body'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelPinReply.fromJson(String source) =>
      ModelPinReply.fromMap(json.decode(source));
}
