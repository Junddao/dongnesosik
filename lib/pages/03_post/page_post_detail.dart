import 'package:cached_network_image/cached_network_image.dart';
import 'package:dongnesosik/global/enums/view_state.dart';
import 'package:dongnesosik/global/model/pin/model_request_create_pin_reply.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:dongnesosik/pages/components/ds_carousel.dart';
import 'package:dongnesosik/pages/components/ds_photo_view.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class PagePostDetail extends StatefulWidget {
  const PagePostDetail({Key? key}) : super(key: key);

  @override
  _PagePostDetailState createState() => _PagePostDetailState();
}

class _PagePostDetailState extends State<PagePostDetail> {
  TextEditingController _tecMessage = TextEditingController();

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
    return Consumer<LocationProvider>(builder: (_, data, __) {
      if (data.state == ViewState.Busy) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 30,
                width: double.infinity,
                child: Center(child: Icon(Ionicons.chevron_down_outline))),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DSPhotoView(
                        iamgeUrls: data.selectedPinData!.pin!.images ?? []),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(data.selectedPinData!.pin!.title!,
                              style: DSTextStyles.bold18Black),
                          SizedBox(height: 20),
                          Text(data.selectedPinData!.pin!.body!),
                          SizedBox(height: 30),
                          Divider(),
                          _buildReviewList(data),
                        ],
                      ),
                    ),

                    // const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
            _buildMessageComposer(data),
          ],
        ),
      );
    });
  }

  Widget _buildMessageComposer(LocationProvider data) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            // height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Icon(Icons.add_a_photo),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 42,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFEFEFEF)),
                      borderRadius: BorderRadius.circular(21),
                      color: Color(0xFFF8F8F8),
                    ),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _tecMessage,
                            onChanged: (value) {},
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                              hintText: '메세지를 입력하세요',
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            child: Icon(Icons.send),
                            padding: EdgeInsets.all(4),
                          ),
                          onTap: () {
                            createReply();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewList(LocationProvider provider) {
    return provider.responseGetPinReplyData!.length == 0
        ? emptyReview()
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: provider.responseGetPinReplyData!.length,
            itemBuilder: (context, index) {
              var data = provider.responseGetPinReplyData![index];

              return InkWell(
                onTap: () {
                  context.read<LocationProvider>().setReplyTarget(data);
                  _tecMessage.text = '@${data.name} ';
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(data.name!, style: DSTextStyles.bold12Black),
                        SizedBox(width: 16),
                        Text(data.createAt ?? '20000',
                            style: DSTextStyles.regular10WarmGrey),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      data.reply!.body!,
                      style: DSTextStyles.regular12Black,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          );
  }

  Widget emptyReview() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('리뷰 없음'),
        ],
      ),
    );
  }

  void createReply() {
    var provider = context.read<LocationProvider>();
    if (_tecMessage.text.isEmpty) {
      return;
    }

    // 대댓글 처리용
    if (provider.selectedReplyData != null) {}

    ModelRequestCreatePinReply modelRequestCreatePinReply =
        ModelRequestCreatePinReply(
      pinId: provider.selectedPinData!.pin!.id,
      body: _tecMessage.text,
      password: '0000',
    );
    _tecMessage.text = '';
    provider.createReply(modelRequestCreatePinReply).then((value) {
      context
          .read<LocationProvider>()
          .getPinReply(provider.selectedPinData!.pin!.id!);
    });
  }

  void goCommunityPage() async {
    Navigator.of(context).pushNamed('PagePostCommunity');
  }
}
