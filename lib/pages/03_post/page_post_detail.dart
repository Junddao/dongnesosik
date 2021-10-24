import 'package:cached_network_image/cached_network_image.dart';
import 'package:dongnesosik/global/model/pin/response_get_pin.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:dongnesosik/pages/components/ds_carousel.dart';
import 'package:dongnesosik/pages/components/ds_photo_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PagePostDetail extends StatefulWidget {
  const PagePostDetail({Key? key}) : super(key: key);

  @override
  _PagePostDetailState createState() => _PagePostDetailState();
}

class _PagePostDetailState extends State<PagePostDetail> {
  List<String> imageUrls = [test_image_url, test_image_url, test_image_url];
  @override
  void initState() {
    Future.microtask(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ResponseGetPinData selectedGetPinData =
        context.watch<LocationProvider>().selectedPinData!;
    return Scaffold(
      appBar: _appBar(selectedGetPinData),
      bottomSheet: _bottomButton(),
      body: _body(selectedGetPinData),
    );
  }

  AppBar _appBar(ResponseGetPinData selectedGetPinData) {
    return AppBar(title: Text('${selectedGetPinData.pin!.title}'));
  }

  Widget _bottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      child: DSButton(
          text: '대화방 보기',
          width: SizeConfig.screenWidth,
          press: goCommunityPage),
    );
  }

  _body(ResponseGetPinData selectedGetPinData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DSPhotoView(iamgeUrls: imageUrls),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(selectedGetPinData.pin!.title!,
                    style: DSTextStyles.bold18Black),
                SizedBox(height: 20),
                Text(selectedGetPinData.pin!.body!),
              ],
              //iimage - size는 작게
              //body
            ),
          ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }

  void goCommunityPage() async {
    Navigator.of(context).pushNamed('PagePostCommunity');
  }
}
