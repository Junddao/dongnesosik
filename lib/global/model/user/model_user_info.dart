import 'dart:convert';

class ModelUserInfo {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? profileImage;
  ModelUserInfo({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'profileImage': profileImage,
    };
  }

  factory ModelUserInfo.fromMap(Map<String, dynamic> map) {
    return ModelUserInfo(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] : null,
      email: map['email'] != null ? map['email'] : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelUserInfo.fromJson(String source) =>
      ModelUserInfo.fromMap(json.decode(source));

  ModelUserInfo copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? profileImage,
  }) {
    return ModelUserInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
