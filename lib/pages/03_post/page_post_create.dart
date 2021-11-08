import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dongnesosik/global/model/pin/model_request_create_pin.dart';
import 'package:dongnesosik/global/provider/file_provider.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_image_picker.dart';
import 'package:dongnesosik/pages/components/ds_two_button_dialog.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PagePostCreate extends StatefulWidget {
  const PagePostCreate({Key? key}) : super(key: key);

  @override
  _PagePostCreateState createState() => _PagePostCreateState();
}

class _PagePostCreateState extends State<PagePostCreate> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<File> _images = [];
  List<String> _imageUrls = [];
  List<AssetEntity> _selectedAssetList = [];
  map.LatLng? location;
  String? address;

  LatLng? myPostLocation;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
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
      automaticallyImplyLeading: false,
      title: Text('글쓰기'),
      leading: TextButton(
        onPressed: () {
          DSTwoButtonDialog.showCancelDialog(context: context).then((value) {
            setState(() {
              if (value == true) {
                context.read<LocationProvider>().setMyPostLocation(null);
                Navigator.of(context).pop();
              }
            });
          });
        },
        child: Text(
          '취소',
          style: DSTextStyles.medium14WarmGrey,
        ),
      ),
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
    return SingleChildScrollView(
      physics: new ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultHorizontalPadding,
            vertical: kDefaultVerticalPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 1. 제목
              postTitle(),
              SizedBox(height: 20),
              // 2. 내용
              postContents(),
              SizedBox(height: 20),
              // 3. 위치지정
              postLocation(),
              SizedBox(height: 20),
              // 4. 이미지
              postImages(),
            ],
          ),
        ),
      ),
    );
  }

  postTitle() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('제목', style: DSTextStyles.bold16Black),
            SizedBox(height: 40),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 54,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: DSColors.pinkish_grey, width: 1)),
          child: TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: "제목을 입력해주세요.",
              hintStyle: DSTextStyles.medium16WhiteThree,
              labelStyle: TextStyle(color: Colors.transparent),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            validator: (text) {
              return text == null ? '제목을 입력해주세요.' : null;
            },
          ),
        ),
      ],
    );
  }

  postContents() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('내용', style: DSTextStyles.bold16Black),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 150,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: DSColors.pinkish_grey, width: 1)),
          child: TextFormField(
            maxLines: null,
            controller: _bodyController,
            decoration: InputDecoration(
              hintText: "내용을 입력해주세요.",
              hintStyle: DSTextStyles.medium16WhiteThree,
              labelStyle: TextStyle(color: Colors.transparent),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            validator: (text) {
              return text == null ? '제목을 입력해주세요.' : null;
            },
          ),
        ),
      ],
    );
  }

  postLocation() {
    var provider = context.watch<LocationProvider>();
    // String? address = provider.placemarks[0].name!;
    String? address = provider.placemarks[0].locality! +
        " " +
        provider.placemarks[0].subLocality! +
        " " +
        provider.placemarks[0].thoroughfare! +
        " " +
        provider.placemarks[0].subThoroughfare!;
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('장소', style: DSTextStyles.bold16Black),
          SizedBox(width: 8),
          InkWell(
            onTap: () {
              getMyLocation();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: DSColors.greyish),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('현재 위치로 선택', style: DSTextStyles.regular12Greyish),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('PageSelectLocation');
        },
        child: Row(
          children: [
            Icon(Icons.location_pin, color: DSColors.pinkish_grey),
            SizedBox(width: 10),
            provider.myPostLocation == null
                ? Text('위치 선택', style: DSTextStyles.regular14PinkishGrey)
                : Text(address, style: DSTextStyles.regular12Black),
          ],
        ),
      ),
      SizedBox(height: 10),
    ]);
  }

  getMyLocation() {
    var provider = context.read<LocationProvider>();
    location = provider.setMyPostLocation(provider.myLocation!);
    provider.getAddress(provider.myLocation!);
  }

  postImages() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('사진', style: DSTextStyles.bold16Black),
        ],
      ),
      SizedBox(height: 10),
      Container(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            getAddPhotoBtn(),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedAssetList.length,
                itemBuilder: (context, index) {
                  return getImages(index);
                },
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget getImages(index) {
    return RawMaterialButton(
      onPressed: () async {
        // 클릭했을때 list 에 추가하고, 순서하고

        _selectedAssetList.removeAt(index);

        _images.removeAt(index);
        setState(() {});
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                    width: 60,
                    height: 60,
                    image: AssetEntityImageProvider(_selectedAssetList[index],
                        isOriginal: false))
                // child: CachedNetworkImage(
                //   imageUrl: imageUrls[index],
                //   width: 60,
                //   height: 60,
                //   fit: BoxFit.cover,
                // ),
                ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: _getSelectedPhotoEraseCircle(),
          )
        ],
      ),
    );
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

  Widget _getSelectedPhotoEraseCircle() {
    return Container(
      height: 20,
      width: 20,
      child: CircleAvatar(
        child: Icon(
          Icons.close,
          size: 16,
          color: Colors.white.withOpacity(0.8),
        ),
        backgroundColor: DSColors.black05.withOpacity(0.8),
      ),
    );
  }

  Widget getAddPhotoBtn() {
    return InkWell(
      onTap: () async {
        _selectedAssetList = (await DSImagePicker().cameraAndStay(
            context: context, assets: _selectedAssetList, maxAssetsCount: 5))!;
        await getFileList();
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, right: 10),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(color: DSColors.black05, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Ionicons.images_outline,
                color: DSColors.black05,
              ),
              SizedBox(height: 4),
              Text(
                '${_selectedAssetList.length} / 5',
                style: DSTextStyles.medium10Grey06,
              ),
            ],
          ),
        ),
      ),
    );
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

    location = context.read<LocationProvider>().myPostLocation;
    EasyLoading.show(status: 'loading...');
    // 이미지 보내기
    try {
      await updateImageToServer().catchError((onError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('이미지 업로드에 실패했습니다. 이미지를 다시 선택 후 시도해 주세요.'),
          ),
        );
        throw Exception();
      });
      ModelRequestCreatePin requestCreatePin = ModelRequestCreatePin(
        lat: location!.latitude,
        lng: location!.longitude,
        title: _titleController.text,
        body: _bodyController.text,
        images: _imageUrls,
      );

      await context
          .read<LocationProvider>()
          .createPin(requestCreatePin)
          .catchError((onError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('생성에 실패하였습니다. 다시 시도해 주세요.'),
          ),
        );
        throw Exception();
      });
      EasyLoading.dismiss();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('PageMap', (route) => false);
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
