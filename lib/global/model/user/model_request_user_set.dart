import 'dart:convert';

class ModelRequestUserSet {
  String? name;
  String? phoneNumber;
  String? email;
  String? profileImage;
  ModelRequestUserSet({
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

  factory ModelRequestUserSet.fromMap(Map<String, dynamic> map) {
    return ModelRequestUserSet(
      name: map['name'] != null ? map['name'] : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] : null,
      email: map['email'] != null ? map['email'] : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestUserSet.fromJson(String source) =>
      ModelRequestUserSet.fromMap(json.decode(source));

  ModelRequestUserSet copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? profileImage,
  }) {
    return ModelRequestUserSet(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
