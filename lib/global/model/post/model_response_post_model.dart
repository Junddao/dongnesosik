import 'dart:convert';

class ModelResponsePost {
  String? result;
  String? message;
  List<ModelResponsePostData>? data;
  ModelResponsePost({
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

  factory ModelResponsePost.fromMap(Map<String, dynamic> map) {
    return ModelResponsePost(
      result: map['result'],
      message: map['message'],
      data: List<ModelResponsePostData>.from(
          map['data']?.map((x) => ModelResponsePostData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponsePost.fromJson(String source) =>
      ModelResponsePost.fromMap(json.decode(source));
}

class ModelResponsePostData {
  int? id;
  String? userName;
  String? title;
  String? contents;
  List<String>? imageUrls;
  String? createDate;
  ModelResponsePostData({
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

  factory ModelResponsePostData.fromMap(Map<String, dynamic> map) {
    return ModelResponsePostData(
      userName: map['userName'],
      title: map['title'],
      contents: map['contents'],
      imageUrls: List<String>.from(map['imageUrls']),
      createDate: map['createDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponsePostData.fromJson(String source) =>
      ModelResponsePostData.fromMap(json.decode(source));
}
