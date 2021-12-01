import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:flutter/material.dart';

class DSLastSlide extends StatelessWidget {
  const DSLastSlide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 140),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Container(
                  height: 1,
                  color: DSColors.tomato,
                ),
              ),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Text(
                  "동네소식은\n동네소식으로. 😃\n\n",
                  style: DSTextStyles.bold20Black36,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 143),
                child: Container(
                  height: 7,
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                      color: DSColors.tomato,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
