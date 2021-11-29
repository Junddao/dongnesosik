import 'dart:convert';

class ModelFileResponse {
  String? result;
  String? message;
  FileModel? data;
  ModelFileResponse({
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

  factory ModelFileResponse.fromMap(Map<String, dynamic> map) {
    return ModelFileResponse(
      result: map['result'],
      message: map['message'],
      data: FileModel.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelFileResponse.fromJson(String source) =>
      ModelFileResponse.fromMap(json.decode(source));
}

class FileModel {
  List<String>? images;
  List<String>? files;
  FileModel({
    this.images,
    this.files,
  });

  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'files': files,
    };
  }

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      images: List<String>.from(map['images']),
      files: List<String>.from(map['files']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FileModel.fromJson(String source) =>
      FileModel.fromMap(json.decode(source));
}
