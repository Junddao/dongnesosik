import 'dart:convert';

class RequestGetPinRange {
  double? lat;
  double? lng;
  int? range;
  RequestGetPinRange({
    this.lat,
    this.lng,
    this.range,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'range': range,
    };
  }

  factory RequestGetPinRange.fromMap(Map<String, dynamic> map) {
    return RequestGetPinRange(
      lat: map['lat'],
      lng: map['lng'],
      range: map['range'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestGetPinRange.fromJson(String source) =>
      RequestGetPinRange.fromMap(json.decode(source));
}
