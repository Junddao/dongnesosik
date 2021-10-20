import 'package:dongnesosik/global/style/constants.dart';
import 'package:flutter/material.dart';

class PageUserSetting extends StatefulWidget {
  const PageUserSetting({Key? key}) : super(key: key);

  @override
  _PageUserSettingState createState() => _PageUserSettingState();
}

class _PageUserSettingState extends State<PageUserSetting> {
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
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultHorizontalPadding,
            vertical: kDefaultVerticalPadding),
        child: Column(
          children: [
            Text('user Setting'),
          ],
        ),
      ),
    );
  }
}
