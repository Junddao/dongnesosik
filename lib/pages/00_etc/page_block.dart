import 'package:flutter/material.dart';

class PageBlock extends StatelessWidget {
  const PageBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('다수의 신고로 차단된 상태입니다.'),
          SizedBox(height: 10),
          Text('사용을 원하시면 아래 메일로 문의 바랍니다.'),
          SizedBox(height: 30),
          Text('dongnesosik@gmail.com'),
        ],
      ),
    );
  }
}
