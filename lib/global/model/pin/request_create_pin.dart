import 'dart:convert';

class RequestCreatePin {
  double? lat;
  double? lng;
  String? title;
  String? body;
  RequestCreatePin({
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

  factory RequestCreatePin.fromMap(Map<String, dynamic> map) {
    return RequestCreatePin(
      lat: map['lat'] != null ? map['lat'] : null,
      lng: map['lng'] != null ? map['lng'] : null,
      title: map['title'] != null ? map['title'] : null,
      body: map['body'] != null ? map['body'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestCreatePin.fromJson(String source) =>
      RequestCreatePin.fromMap(json.decode(source));
}
