import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class CDImagePicker {
  Future<List<AssetEntity>?> cameraAndStay(
      {required BuildContext context,
      required List<AssetEntity> assets,
      required int maxAssetsCount}) async {
    return AssetPicker.pickAssets(
      context,
      maxAssets: maxAssetsCount,
      textDelegate: EnglishTextDelegate(),
      selectedAssets: assets,
      requestType: RequestType.image,
      specialItemPosition: SpecialItemPosition.prepend,
      specialItemBuilder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            final AssetEntity? result = await CameraPicker.pickFromCamera(
              context,
              enableRecording: true,
              textDelegate: EnglishCameraPickerTextDelegate(),
            );
            if (result != null) {
              final AssetPicker<AssetEntity, AssetPathEntity> picker =
                  context.findAncestorWidgetOfExactType()!;
              final DefaultAssetPickerProvider p =
                  picker.builder.provider as DefaultAssetPickerProvider;
              await p.currentPathEntity!.refreshPathProperties();
              await p.switchPath(p.currentPathEntity!);
              p.selectAsset(result);
            }
          },
          child: const Center(
            child: Icon(Icons.camera_enhance, size: 42.0),
          ),
        );
      },
    );
  }
}
