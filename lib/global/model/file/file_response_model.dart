import 'dart:convert';

class FileResponse {
  String? result;
  String? message;
  FileModel? data;
  FileResponse({
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

  factory FileResponse.fromMap(Map<String, dynamic> map) {
    return FileResponse(
      result: map['result'],
      message: map['message'],
      data: FileModel.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FileResponse.fromJson(String source) =>
      FileResponse.fromMap(json.decode(source));
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
