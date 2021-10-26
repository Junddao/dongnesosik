import 'dart:io';

import 'package:dongnesosik/global/enums/file_type.dart';
import 'package:dongnesosik/global/model/file/model_file_response.dart';
import 'package:dongnesosik/global/provider/parent_provider.dart';
import 'package:dongnesosik/global/service/api_service.dart';

class FileProvider extends ParentProvider {
  ModelFileResponse? productImageResponse = ModelFileResponse();
  Future<FileModel?> uploadImages(List<File> _images) async {
    try {
      setStateBusy();
      var api = ApiService();
      var response =
          await api.postMultiPart('/file/upload', _images, FileType.image);
      productImageResponse = ModelFileResponse.fromMap(response);
      setStateIdle();
    } catch (error) {
      setStateError();
    }

    return productImageResponse!.data;
  }

  Future<FileModel?> uploadFiles(List<File> _files) async {
    try {
      setStateBusy();
      var api = ApiService();
      var response =
          await api.postMultiPart('/file/upload', _files, FileType.file);
      productImageResponse = ModelFileResponse.fromMap(response);
      setStateIdle();
    } catch (error) {
      setStateError();
    }
    return productImageResponse!.data;
  }
}
