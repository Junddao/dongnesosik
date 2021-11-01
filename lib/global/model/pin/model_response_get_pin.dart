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
  ResponsePin? pin;
  String? name;
  ResponseGetPinData({
    this.pin,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'pin': pin?.toMap(),
      'name': name,
    };
  }

  factory ResponseGetPinData.fromMap(Map<String, dynamic> map) {
    return ResponseGetPinData(
      pin: map['pin'] != null ? ResponsePin.fromMap(map['pin']) : null,
      name: map['name'] != null ? map['name'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseGetPinData.fromJson(String source) =>
      ResponseGetPinData.fromMap(json.decode(source));
}

class ResponsePin {
  int? id;
  double? lat;
  double? lng;
  String? title;
  String? body;
  List<String>? images;
  ResponsePin({
    this.id,
    this.lat,
    this.lng,
    this.title,
    this.body,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lat': lat,
      'lng': lng,
      'title': title,
      'body': body,
      'Images': images,
    };
  }

  factory ResponsePin.fromMap(Map<String, dynamic> map) {
    return ResponsePin(
      id: map['id'] != null ? map['id'] : null,
      lat: map['lat'] != null ? map['lat'] : null,
      lng: map['lng'] != null ? map['lng'] : null,
      title: map['title'] != null ? map['title'] : null,
      body: map['body'] != null ? map['body'] : null,
      images: map['images'] != null ? List<String>.from(map['images']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponsePin.fromJson(String source) =>
      ResponsePin.fromMap(json.decode(source));
}
