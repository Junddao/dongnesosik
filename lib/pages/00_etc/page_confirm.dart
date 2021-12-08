import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:flutter/material.dart';

class PageConfirm extends StatefulWidget {
  const PageConfirm({Key? key}) : super(key: key);

  @override
  _PageConfirmState createState() => _PageConfirmState();
}

class _PageConfirmState extends State<PageConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(24),
        child: DSButton(
          width: MediaQuery.of(context).size.width - 48,
          text: '확인',
          type: ButtonType.dark,
          press: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('PageMap', (route) => false);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, color: DSColors.tomato, size: 24),
            SizedBox(
              height: 24,
            ),
            Text('신고 완료', style: DSTextStyles.bold20Black36),
            SizedBox(height: 24),
            Text(
              '신고가 정상 접수 되었습니다.',
              style: DSTextStyles.regular14Black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
