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
  bool? isAdmin;
  String? name;
  String? phoneNumber;
  String? email;
  String? profileImage;
  String? state;
  String? address;
  String? region1;
  String? region2;
  String? region3;
  String? loadName;
  String? mainBuildingNo;
  String? subBuildingNo;
  String? buildingName;
  ModelResponseUserGetData({
    this.id,
    this.isAdmin,
    this.name,
    this.phoneNumber,
    this.email,
    this.profileImage,
    this.state = 'active',
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
      'isAdmin': isAdmin,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'profileImage': profileImage,
      'state': state,
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

  factory ModelResponseUserGetData.fromMap(Map<String, dynamic> map) {
    return ModelResponseUserGetData(
      id: map['id'] != null ? map['id'] : null,
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] : null,
      name: map['name'] != null ? map['name'] : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] : null,
      email: map['email'] != null ? map['email'] : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] : null,
      state: map['state'] != null ? map['state'] : null,
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
