import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ButtonType {
  const ButtonType._(this.type);

  final String type;
  static const normal = ButtonType._('normal');

  static const dark = ButtonType._('dark');
  static const success = ButtonType._('success');
  static const warning = ButtonType._('warning');
  static const disabled = ButtonType._('disabled');
  static const transparent = ButtonType._('transparent');
  static const normal_black = ButtonType._('default_black');
  static const decline = ButtonType._('decline');

  @override
  String toString() {
    return const <String, String>{
      'normal': 'ButtonType.normal',
      'dark': 'ButtonType.dark',
      'transparent': 'ButtonType.transparent',
      'success': 'ButtonType.success',
      'warning': 'ButtonType.warning',
      'disabled': 'ButtonType.disabled',
      'normal_black': 'ButtonType.normal_black',
      'decline': 'ButtonType.decline'
    }[type]!;
  }

  Color? buttonColor() {
    return const <String, Color>{
      'normal': DSColors.tomato,
      'dark': DSColors.purple_red,
      'transparent': Colors.transparent,
      'success': DSColors.tomato,
      'warning': DSColors.red01,
      'disabled': DSColors.tomato_10,
      'normal_black': DSColors.black,
      'decline': DSColors.decline,
    }[type];
  }

  Color? textColor() {
    return const <String, Color>{
      'normal': Colors.white,
      'dark': Colors.white,
      'transparent': DSColors.gray3,
      'success': DSColors.gray3,
      'warning': Colors.white,
      'disabled': DSColors.gray3,
      'normal_black': DSColors.gray3,
      'decline': Colors.white,
    }[type];
  }
}

class DSButton extends StatelessWidget {
  // final Size size;
  final String text;
  final Function press;
  final EdgeInsets? margin;
  final double? width;
  final double height;
  final double radius;
  final ButtonType type;
  DSButton({
    // required this.size,
    Key? key,
    required this.text,
    required this.press,
    this.margin,
    this.width,
    this.height = 50,
    this.radius = 14,
    this.type = ButtonType.normal,
  }) : super(key: key);

  Color? color = DSColors.blue03;
  Color? textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    color = type.buttonColor();
    textColor = type.textColor();
    return Container(
      // color: Colors.red,
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 0),
            color: color,
            onPressed: press as void Function()?,
            child: Text(
              text,
              style: DSTextStyle.button.copyWith(color: textColor),
            )),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
  }
}