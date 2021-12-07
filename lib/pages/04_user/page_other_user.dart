import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dongnesosik/global/enums/view_state.dart';

import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/provider/user_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_two_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class PageOtherUser extends StatefulWidget {
  final int? userId;
  const PageOtherUser({Key? key, this.userId}) : super(key: key);

  @override
  _PageOtherUserState createState() => _PageOtherUserState();
}

class _PageOtherUserState extends State<PageOtherUser> {
  @override
  void initState() {
    Future.microtask(() {
      // int pinId = context.read<LocationProvider>().selectedPinData!.pin!.id!;
      context.read<UserProvider>().getUser(widget.userId!);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    var userProvider = context.read<UserProvider>();
    return AppBar(
      title: Consumer<UserProvider>(builder: (_, data, __) {
        return Text(data.selectedUser!.name ?? '');
      }),
      actions: [
        TextButton(
          onPressed: () async {
            var result = await DSDialog.showTwoButtonDialog(
                context: context,
                title: '비매너 신고',
                subTitle: '정말 신고하시겠습니까?',
                btn1Text: '아니요',
                btn2Text: '예');

            if (result == true) {
              // 비매너 신고 api  호출
              userProvider
                  .setUserReport(userProvider.selectedUser!.id!)
                  .then((value) {
                DSDialog.showOneButtonDialog(
                    context: context,
                    title: '신고 완료',
                    subTitle: '신고해 주셔서 감사합니다.',
                    btnText: '확인');
              }).catchError((onError) {
                DSDialog.showOneButtonDialog(
                    context: context,
                    title: '실패',
                    subTitle: '네트워크 상의 문제로 신고가 실패했습니다.',
                    btnText: '확인');
              });
            }
          },
          child: Text('비매너신고', style: DSTextStyles.bold12Tomato),
        ),
      ],
    );
  }

  Widget _body() {
    return Consumer<UserProvider>(builder: (_, data, __) {
      if (data.state == ViewState.Busy) {
        return Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultHorizontalPadding,
              vertical: kDefaultVerticalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: data.selectedUser!.profileImage == null ||
                                data.selectedUser!.profileImage == ''
                            ? SvgPicture.asset(
                                'assets/images/person.svg',
                                fit: BoxFit.cover,
                                height: 80,
                                width: 80,
                              )
                            : CachedNetworkImage(
                                imageUrl: data.selectedUser!.profileImage!,
                                fit: BoxFit.cover,
                                height: 80,
                                width: 80,
                              )),
                  ),
                  SizedBox(width: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '여기는\n',
                                style: DSTextStyles.bold14WarmGrey),
                            TextSpan(
                                text: '${data.selectedUser!.name}\n',
                                style: DSTextStyles.bold14Black),
                            TextSpan(
                                text: '님의 공간!',
                                style: DSTextStyles.bold14WarmGrey),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                      backgroundColor: DSColors.tomato,
                      radius: 16.0,
                      child: Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                        size: 16,
                      )),
                  SizedBox(width: 8),
                  Text('${data.selectedUser!.email ?? '이메일 없음'}'),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              ListTile(
                title: Text('ㅌㅌㅌ 님이 쓴 글', style: DSTextStyles.bold18Black),
                trailing: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      );
    });
  }
}
