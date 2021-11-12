import 'dart:convert';

class ModelRequestCreatePin {
  String? password;
  double? lat;
  double? lng;
  String? title;
  String? body;
  List<String>? images;
  int? likeCount;
  ModelRequestCreatePin({
    this.password,
    this.lat,
    this.lng,
    this.title,
    this.body,
    this.images,
    this.likeCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'lat': lat,
      'lng': lng,
      'title': title,
      'body': body,
      'images': images,
      'likeCount': likeCount,
    };
  }

  factory ModelRequestCreatePin.fromMap(Map<String, dynamic> map) {
    return ModelRequestCreatePin(
      password: map['password'] != null ? map['password'] : null,
      lat: map['lat'] != null ? map['lat'] : null,
      lng: map['lng'] != null ? map['lng'] : null,
      title: map['title'] != null ? map['title'] : null,
      body: map['body'] != null ? map['body'] : null,
      images: map['images'] != null ? List<String>.from(map['images']) : null,
      likeCount: map['likeCount'] != null ? map['likeCount'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestCreatePin.fromJson(String source) =>
      ModelRequestCreatePin.fromMap(json.decode(source));
}
