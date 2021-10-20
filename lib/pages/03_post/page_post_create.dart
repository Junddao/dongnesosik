import 'package:flutter/material.dart';

class PagePostCreate extends StatefulWidget {
  const PagePostCreate({Key? key}) : super(key: key);

  @override
  _PagePostCreateState createState() => _PagePostCreateState();
}

class _PagePostCreateState extends State<PagePostCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('글쓰기'),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 1. 제목
          // 2. 내용
          // 3. 위치지정
          // 4. 이미지
          // 5. 확인버튼 (bottom sheet 또는 appbar 에 추가)
        ],
      ),
    );
  }
}
