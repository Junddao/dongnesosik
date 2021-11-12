import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/model/user/model_request_user_set.dart';
import 'package:dongnesosik/global/provider/file_provider.dart';
import 'package:dongnesosik/global/provider/user_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_image_picker.dart';
import 'package:dongnesosik/pages/components/ds_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PageUserSetting extends StatefulWidget {
  const PageUserSetting({Key? key}) : super(key: key);

  @override
  _PageUserSettingState createState() => _PageUserSettingState();
}

class _PageUserSettingState extends State<PageUserSetting> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _tecName = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];
  List<String> _imageUrls = [];
  List<AssetEntity> _selectedAssetList = [];

  @override
  void dispose() {
    _tecName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('내정보'),
      actions: [
        TextButton(
          onPressed: () {
            onSave();
          },
          child: Text(
            '등록',
            style: DSTextStyles.bold14Tomato,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    final FocusScopeNode node = FocusScope.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultHorizontalPadding,
            vertical: kDefaultVerticalPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      _selectedAssetList = (await DSImagePicker().cameraAndStay(
                          context: context,
                          assets: _selectedAssetList,
                          maxAssetsCount: 1))!;
                      await getFileList();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(300),
                              child: _selectedAssetList.isEmpty
                                  ? SingletonUser.singletonUser.userData
                                                  .profileImage ==
                                              null ||
                                          SingletonUser.singletonUser.userData
                                                  .profileImage ==
                                              ''
                                      ? SvgPicture.asset(
                                          'assets/images/person.svg',
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 80,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: SingletonUser.singletonUser
                                              .userData.profileImage!,
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 80,
                                        )
                                  : Image(
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width: 80,
                                      image: AssetEntityImageProvider(
                                          _selectedAssetList[0],
                                          isOriginal: false))),
                          Positioned(
                            top: 60,
                            left: 60,
                            child: Container(
                              alignment: Alignment.center,
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: DSColors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: 1, color: DSColors.grey_06)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: DSColors.grey_06,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 18),
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '안녕하세요 ',
                                style: DSTextStyles.bold18WarmGrey),
                            TextSpan(
                                text:
                                    '${SingletonUser.singletonUser.userData.name}',
                                style: DSTextStyles.bold18Black),
                            TextSpan(
                                text: '님!', style: DSTextStyles.bold18WarmGrey),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('${SingletonUser.singletonUser.userData.email!}'),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),
              DSInputField(
                controller: _tecName,
                // title: "성명",
                hintText: "변경하실 성명을 입력해주세요",
                warningMessage: "성명을 입력해주세요",
                onEditingComplete: () => node.nextFocus(),
              ),
              // DSInputField(
              //   controller: _tecPhone,
              //   title: "연락처:",
              //   hintText: "거래처와의 연락 및 고객지원을 위해 사용됩니다.",
              //   warningMessage: "연락처를 입력해주세요",
              //   keyboardType: TextInputType.phone,
              //   inputFormatters: [TextInputFormatterPhone()],
              // ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void onSave() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("빈칸을 채워주세요."),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }
    EasyLoading.show(status: 'loading...', dismissOnTap: true);

    try {
      await updateImageToServer().catchError((onError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('이미지 업로드에 실패했습니다. 이미지를 다시 선택 후 시도해 주세요.'),
          ),
        );
        throw Exception();
      });
      SingletonUser.singletonUser.userData.name = _tecName.text;
      SingletonUser.singletonUser.userData.profileImage = _imageUrls[0];

      ModelRequestUserSet modelRequestUserSet = ModelRequestUserSet.fromMap(
          SingletonUser.singletonUser.userData.toMap());

      context.read<UserProvider>().setUser(modelRequestUserSet);
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> updateImageToServer() async {
    if (_images.isNotEmpty) {
      await context
          .read<FileProvider>()
          .uploadImages(_images)
          .then((value) async {
        _imageUrls = value!.images!;
      });
    }
  }

  Future<void> getFileList() async {
    _images.clear();

    for (final AssetEntity asset in _selectedAssetList) {
      // If the entity `isAll`, that's the "Recent" entity you want.
      File? file = await asset.originFile;
      if (file != null) {
        var filePath = file.absolute.path;
        print('original size = ${asset.width} / ${asset.height}');
        if (asset.width > 1080 && asset.height > 1080) {
          final int? shorterSide =
              asset.width < asset.height ? asset.width : asset.height;
          final int resizePercent = (1080.0 / shorterSide! * 100).toInt();

          File compressedFile = await FlutterNativeImage.compressImage(filePath,
              quality: 50, percentage: resizePercent);

          print('resize Percent = $resizePercent');
          print('compressed File = ${compressedFile.toString()}');

          filePath = compressedFile.path;
        }
        try {
          if (filePath.toLowerCase().endsWith(".heic") ||
              filePath.toLowerCase().endsWith(".heif")) {
            String? jpgPath = await HeicToJpg.convert(filePath);
            File file = File(jpgPath!);

            _images.add(file);
          } else {
            File file = File(filePath);

            _images.add(file);
          }
        } on Exception catch (e) {
          print(e.toString());
        }
      }
    }
  }
}
