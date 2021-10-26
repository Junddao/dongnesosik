import 'dart:convert';

class ModelUserInfo {
  String? name;
  String? phoneNumber;
  String? email;
  String? profileImage;
  ModelUserInfo({
    this.name,
    this.phoneNumber,
    this.email,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'profileImage': profileImage,
    };
  }

  factory ModelUserInfo.fromMap(Map<String, dynamic> map) {
    return ModelUserInfo(
      name: map['name'] != null ? map['name'] : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] : null,
      email: map['email'] != null ? map['email'] : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelUserInfo.fromJson(String source) =>
      ModelUserInfo.fromMap(json.decode(source));
}
