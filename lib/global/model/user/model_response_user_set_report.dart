import 'dart:convert';

class ModelResponseUserSetReport {
  String? result;
  String? message;
  UserReport? data;
  ModelResponseUserSetReport({
    this.result,
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory ModelResponseUserSetReport.fromMap(Map<String, dynamic> map) {
    return ModelResponseUserSetReport(
      result: map['result'] != null ? map['result'] : null,
      message: map['message'] != null ? map['message'] : null,
      data: map['data'] != null ? UserReport.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseUserSetReport.fromJson(String source) =>
      ModelResponseUserSetReport.fromMap(json.decode(source));
}

class UserReport {
  bool? reported;
  UserReport({
    this.reported = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'reported': reported,
    };
  }

  factory UserReport.fromMap(Map<String, dynamic> map) {
    return UserReport(
      reported: map['reported'] != null ? map['reported'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReport.fromJson(String source) =>
      UserReport.fromMap(json.decode(source));
}
