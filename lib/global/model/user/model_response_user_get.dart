import 'dart:convert';

class ModelResponseUserGet {
  String? result;
  String? message;
  ModelResponseUserGetData? data;
  ModelResponseUserGet({
    this.result,
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory ModelResponseUserGet.fromMap(Map<String, dynamic> map) {
    return ModelResponseUserGet(
      result: map['result'] != null ? map['result'] : null,
      message: map['message'] != null ? map['message'] : null,
      data: map['data'] != null
          ? ModelResponseUserGetData.fromMap(map['data'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseUserGet.fromJson(String source) =>
      ModelResponseUserGet.fromMap(json.decode(source));
}

class ModelResponseUserGetData {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? profileImage;
  ModelResponseUserGetData({
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

  factory ModelResponseUserGetData.fromMap(Map<String, dynamic> map) {
    return ModelResponseUserGetData(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] : null,
      email: map['email'] != null ? map['email'] : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseUserGetData.fromJson(String source) =>
      ModelResponseUserGetData.fromMap(json.decode(source));

  ModelResponseUserGetData copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? profileImage,
  }) {
    return ModelResponseUserGetData(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
