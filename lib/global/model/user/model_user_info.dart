import 'dart:convert';

class ModelUserInfo {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? profileImage;
  String? address;
  String? region1;
  String? region2;
  String? region3;
  String? loadName;
  String? mainBuildingNo;
  String? subBuildingNo;
  String? buildingName;
  ModelUserInfo({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.profileImage,
    this.address,
    this.region1,
    this.region2,
    this.region3,
    this.loadName,
    this.mainBuildingNo,
    this.subBuildingNo,
    this.buildingName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'profileImage': profileImage,
      'address': address,
      'region1': region1,
      'region2': region2,
      'region3': region3,
      'loadName': loadName,
      'mainBuildingNo': mainBuildingNo,
      'subBuildingNo': subBuildingNo,
      'buildingName': buildingName,
    };
  }

  factory ModelUserInfo.fromMap(Map<String, dynamic> map) {
    return ModelUserInfo(
      id: map['id'] != null ? map['id'] : null,
      name: map['name'] != null ? map['name'] : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] : null,
      email: map['email'] != null ? map['email'] : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] : null,
      address: map['address'] != null ? map['address'] : null,
      region1: map['region1'] != null ? map['region1'] : null,
      region2: map['region2'] != null ? map['region2'] : null,
      region3: map['region3'] != null ? map['region3'] : null,
      loadName: map['loadName'] != null ? map['loadName'] : null,
      mainBuildingNo:
          map['mainBuildingNo'] != null ? map['mainBuildingNo'] : null,
      subBuildingNo: map['subBuildingNo'] != null ? map['subBuildingNo'] : null,
      buildingName: map['buildingName'] != null ? map['buildingName'] : null,
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
