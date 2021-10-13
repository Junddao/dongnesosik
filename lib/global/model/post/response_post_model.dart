import 'dart:convert';

class ResponsePostModel {
  String? result;
  String? message;
  List<ResponsePostDataModel>? data;
  ResponsePostModel({
    this.result,
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponsePostModel.fromMap(Map<String, dynamic> map) {
    return ResponsePostModel(
      result: map['result'],
      message: map['message'],
      data: List<ResponsePostDataModel>.from(
          map['data']?.map((x) => ResponsePostDataModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponsePostModel.fromJson(String source) =>
      ResponsePostModel.fromMap(json.decode(source));
}

class ResponsePostDataModel {
  int? id;
  String? userName;
  String? title;
  String? contents;
  List<String>? imageUrls;
  String? createDate;
  ResponsePostDataModel({
    this.id,
    this.userName,
    this.title,
    this.contents,
    this.imageUrls,
    this.createDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'title': title,
      'contents': contents,
      'imageUrls': imageUrls,
      'createDate': createDate,
    };
  }

  factory ResponsePostDataModel.fromMap(Map<String, dynamic> map) {
    return ResponsePostDataModel(
      userName: map['userName'],
      title: map['title'],
      contents: map['contents'],
      imageUrls: List<String>.from(map['imageUrls']),
      createDate: map['createDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponsePostDataModel.fromJson(String source) =>
      ResponsePostDataModel.fromMap(json.decode(source));
}
