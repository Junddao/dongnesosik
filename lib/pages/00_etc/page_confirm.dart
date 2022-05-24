import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:flutter/material.dart';

class PageConfirm extends StatefulWidget {
  final title;
  final contents1;
  final contents2;
  const PageConfirm({Key? key, this.title, this.contents1, this.contents2})
      : super(key: key);

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
          type: ButtonType.normal,
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
            Text(widget.title, style: DSTextStyles.bold20Black36),
            SizedBox(height: 24),
            Text(
              widget.contents1,
              style: DSTextStyles.regular14Black,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Text(
              widget.contents2,
              style: DSTextStyles.regular14Black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
