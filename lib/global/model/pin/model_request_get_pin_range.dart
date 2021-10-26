import 'dart:convert';

class ModelRequestGetPinRange {
  double? lat;
  double? lng;
  int? range;
  ModelRequestGetPinRange({
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

  factory ModelRequestGetPinRange.fromMap(Map<String, dynamic> map) {
    return ModelRequestGetPinRange(
      lat: map['lat'],
      lng: map['lng'],
      range: map['range'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestGetPinRange.fromJson(String source) =>
      ModelRequestGetPinRange.fromMap(json.decode(source));
}
