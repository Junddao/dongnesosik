import 'dart:convert';

class ModelRequestCreatePin {
  double? lat;
  double? lng;
  String? title;
  String? body;
  ModelRequestCreatePin({
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

  factory ModelRequestCreatePin.fromMap(Map<String, dynamic> map) {
    return ModelRequestCreatePin(
      lat: map['lat'] != null ? map['lat'] : null,
      lng: map['lng'] != null ? map['lng'] : null,
      title: map['title'] != null ? map['title'] : null,
      body: map['body'] != null ? map['body'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestCreatePin.fromJson(String source) =>
      ModelRequestCreatePin.fromMap(json.decode(source));
}
