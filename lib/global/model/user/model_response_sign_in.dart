import 'dart:convert';

class ModelResponseSignIn {
  String? accessToken;
  int? userId;
  ModelResponseSignIn({
    this.accessToken,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'userId': userId,
    };
  }

  factory ModelResponseSignIn.fromMap(Map<String, dynamic> map) {
    return ModelResponseSignIn(
      accessToken: map['accessToken'] != null ? map['accessToken'] : null,
      userId: map['userId'] != null ? map['userId'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseSignIn.fromJson(String source) =>
      ModelResponseSignIn.fromMap(json.decode(source));
}
