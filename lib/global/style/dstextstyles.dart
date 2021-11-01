import 'package:flutter/material.dart';
import 'dscolors.dart';

class DSTextStyles {
  static const nav = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: Color(0xFF1F1F1F),
      fontStyle: FontStyle.normal);
  static const title2 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: DSColors.text2);
  static const body2 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: DSColors.text2);
  static const button =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white);
  static const cellBoldBody = TextStyle(
      fontSize: 13, fontWeight: FontWeight.w700, color: DSColors.text2);
  static const cellBody = TextStyle(
      fontSize: 13, fontWeight: FontWeight.w400, color: DSColors.text2);

  static const h1 = TextStyle(
      fontSize: 38, fontWeight: FontWeight.w400, color: DSColors.gray9);
  static const h2 = TextStyle(
      fontSize: 28, fontWeight: FontWeight.w400, color: DSColors.gray9);
  static const h3 = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w400, color: DSColors.gray9);
  static const h4 = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w400, color: DSColors.gray9);
  static const h5 = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: DSColors.gray9);
  static const h6 = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: DSColors.gray9);
  static const p1 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: DSColors.gray9);
  static const p2 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: DSColors.gray9);
  static const p3 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: DSColors.gray9);
  static const p4 = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w300, color: DSColors.gray9);
  static const p5 = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w200, color: DSColors.gray9);

  static regularFont({double fontSize = 12, color = DSColors.gray9}) {
    return TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.w400, color: color);
  }

  static boldFont({double fontSize = 12, color = DSColors.gray9}) {
    return TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.bold, color: color);
  }

  static const mediaum50White = const TextStyle(
      color: DSColors.white,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 50.0);

  static const bold24Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 24.0);

  static const bold24White = const TextStyle(
      color: const Color(0xffffffff),
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 24.0);

  static const bold20Black36 = const TextStyle(
      color: DSColors.black36,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 20.0);

  static const bold20White = const TextStyle(
      color: const Color(0xffffffff),
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 20.0);

  static const bold20Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 20.0);

  static const bold18Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 18.0);

  static const bold18Black = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 18.0);

  static const bold18FacebookBlue = const TextStyle(
      color: DSColors.facebook_blue,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 18.0);

  static const bold18White = const TextStyle(
      color: DSColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 18.0);

  static const bold16Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  static const bold16PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  static const bold16White = const TextStyle(
      color: const Color(0xffffffff),
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  static const bold16Black = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);
  static const bold13Black = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 13.0);

  static const bold16Tomato = const TextStyle(
      color: DSColors.tomato,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  static const bold16Black2 = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  static const medium16WarmGrey = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  static const medium16Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  static const medium16Black = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  static const bold13Tomato = const TextStyle(
      color: DSColors.tomato,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 13.0);

  static const bold14Tomato = const TextStyle(
      color: DSColors.tomato,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const bold14White = const TextStyle(
      color: const Color(0xffffffff),
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const bold14Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const bold14GrapeFruit = const TextStyle(
      color: DSColors.grapefruit,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const bold14BlackColor = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const bold14Black = const TextStyle(
      color: DSColors.black,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const medium14BlackColor = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const medium10Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  static const medium14Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const medium14Tomato = const TextStyle(
    color: DSColors.tomato,
    fontWeight: FontWeight.w500,
    fontFamily: "NotoSansKR",
    fontStyle: FontStyle.normal,
    fontSize: 14.0,
  );

  static const medium14White = const TextStyle(
      color: DSColors.white,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);
  static const medium14WarmGrey = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const medium14PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular14WarmGrey = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular14Black = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular14Tomato = const TextStyle(
      color: DSColors.tomato,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular14Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular13Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 13.0);

  static const cjkRegular14Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansCJKkr",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const cjkMedium12PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansCJKkr",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const cjkRegular14WarmGrey = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansCJKkr",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular14WhiteTwo = const TextStyle(
      color: DSColors.white_two,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular14White = const TextStyle(
      color: DSColors.white,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular14Grey06_ = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular14PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular14Grey05 = const TextStyle(
      color: DSColors.grey_05,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const regular14Warmgrey = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);
  static const regular16Warmgrey = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);
  static const regular16Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);
  static const regular16Tomato = const TextStyle(
      color: DSColors.tomato,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);
  static const regular12Tomato = const TextStyle(
      color: DSColors.tomato,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const bold12Tomato = const TextStyle(
      color: DSColors.tomato,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const bold12White = const TextStyle(
      color: DSColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const bold12WarmGrey = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);
  static const bold12Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const bold12Black = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const medium12PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const medium12BrownishGrey = const TextStyle(
      color: DSColors.brownish_grey,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const medium12BrownGrey = const TextStyle(
      color: DSColors.brown_grey,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const regular12WarmGrey = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const regular12WarmGrey08 = const TextStyle(
      color: DSColors.warm_grey08,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const regular12White = const TextStyle(
      color: const Color(0xffffffff),
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const regular12Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);
  static const regular8Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 8.0);

  static const regular8White = const TextStyle(
      color: DSColors.white,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 8.0);
  static const regular10Grey06 = const TextStyle(
      color: DSColors.grey_06,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  static const regular12WarmGrey_underline = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      decoration: TextDecoration.underline,
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const regular12Greyish = const TextStyle(
      color: DSColors.greyish,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const regular12PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const regular12Black = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const bold10White = const TextStyle(
      color: const Color(0xffffffff),
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  static const bold10Black = const TextStyle(
      color: DSColors.blackColor,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  static const bold10Tomato = const TextStyle(
      color: DSColors.tomato,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  static const regular10WarmGrey = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  static const regular10WarmGrey__ = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  static const regular10WarmGrey_ = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  static const bold14WarmGrey = const TextStyle(
      color: DSColors.warm_grey,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const medium10PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  static const regular16Pinkish_grey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);
  static const medium16WhiteThree = const TextStyle(
      color: DSColors.white_three,
      fontWeight: FontWeight.w500,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 16.0);
  static const medium13Black_three = const TextStyle(
    color: DSColors.black_three,
    fontFamily: 'NotoSansKR',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );
  static const regular10PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);
  static const bold10PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 10.0);

  static const bold12PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const bold14PinkishGrey = const TextStyle(
      color: DSColors.pinkish_grey,
      fontWeight: FontWeight.w400,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 14.0);

  static const bold20GrapeFruit = const TextStyle(
      color: DSColors.grapefruit,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSansKR",
      fontStyle: FontStyle.normal,
      fontSize: 20.0);

  static const bold26white = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontFamily: 'NotoSansKR',
    fontSize: 26.0,
    fontStyle: FontStyle.normal,
    // height: 1.5,
  );

  static const bold40white = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontFamily: 'NotoSansKR',
    fontSize: 40.0,
    fontStyle: FontStyle.normal,
    // height: 1.5,
  );

  static const bold40black = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontFamily: 'NotoSansKR',
    fontSize: 40.0,
    fontStyle: FontStyle.normal,
    // height: 1.5,
  );

  static const bold26black = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontFamily: 'NotoSansKR',
    fontSize: 26.0,
    fontStyle: FontStyle.normal,
    // height: 1.5,
  );

  static const regular18white = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontFamily: 'NotoSansKR',
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    // height: 1.2,
  );

  static const regular18black = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'NotoSansKR',
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    // height: 1.2,
  );
}
