import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/03_post/components/cell_post_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PagePostCommunity extends StatefulWidget {
  const PagePostCommunity({Key? key}) : super(key: key);

  @override
  _PagePostCommunityState createState() => _PagePostCommunityState();
}

class _PagePostCommunityState extends State<PagePostCommunity> {
  TextEditingController tecMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
      title: Text('대화방', style: DSTextStyles.bold18Black),
    );
  }

  _body() {
    ResponseGetPinData selectedGetPinData =
        context.watch<LocationProvider>().selectedPinData!;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          _buildChatHeader(),
          // Divider(),

          Expanded(
            child: ClipRRect(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: kDefaultVerticalPadding,
                    horizontal: kDefaultHorizontalPadding),
                // height: 300,
                width: double.infinity,
                color: Colors.yellow,
                child: Text('가져온 내용 표시하는 곳입니다. 내가쓴글은 맨 아래에 붙게 되겠네요.'),
              ),
            ),
          ),
          _buildMessageComposer(),
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(color: DSColors.white),
          //     child: ClipRRect(
          //       child: _buildChatMessageList(messages),
          //     ),
          //   ),
          // ),
          // _buildMessageComposer(otherUserData),
        ],
      ),
    );
  }

  Widget _buildChatHeader() {
    return CellPostHeader();
  }

  _buildMessageComposer() {
    return SafeArea(
      child: Container(
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
                        controller: tecMessage,
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
                        child: Icon(Icons.send_to_mobile_outlined),
                        padding: EdgeInsets.all(4),
                      ),
                      onTap: () {
                        sendMessage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    if (tecMessage.text.isEmpty) {
      return;
    }

    // ChatMessage chatMessage = ChatMessage(
    //   sendUserId: Singleton.shared.userData!.userId,
    //   sendUserName: Singleton.shared.userData!.user!.name,
    //   message: tecMessage.text,
    //   type: MessageType.text,
    //   chatRoomId: _chatRoomId,
    // );
    tecMessage.text = '';
    // _sendMessageToServer(chatMessage);
  }
}
