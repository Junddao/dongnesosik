import 'dart:convert';

class ModelResponseGetPin {
  String? result;
  String? message;
  List<ResponseGetPinData>? data;
  ModelResponseGetPin({
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

  factory ModelResponseGetPin.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetPin(
      result: map['result'],
      message: map['message'],
      data: List<ResponseGetPinData>.from(
          map['data']?.map((x) => ResponseGetPinData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetPin.fromJson(String source) =>
      ModelResponseGetPin.fromMap(json.decode(source));
}

class ResponseGetPinData {
  int? id;
  ResponsePin? pin;
  ResponseGetPinData({
    this.id,
    this.pin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pin': pin?.toMap(),
    };
  }

  factory ResponseGetPinData.fromMap(Map<String, dynamic> map) {
    return ResponseGetPinData(
      id: map['id'],
      pin: ResponsePin.fromMap(map['pin']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseGetPinData.fromJson(String source) =>
      ResponseGetPinData.fromMap(json.decode(source));
}

class ResponsePin {
  double? lat;
  double? lng;
  String? title;
  String? body;
  ResponsePin({
    this.lat,
    this.lng,
    this.title,
    this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'title': title,
      'body': body,
    };
  }

  factory ResponsePin.fromMap(Map<String, dynamic> map) {
    return ResponsePin(
      lat: map['lat'],
      lng: map['lng'],
      title: map['title'],
      body: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponsePin.fromJson(String source) =>
      ResponsePin.fromMap(json.decode(source));
}
