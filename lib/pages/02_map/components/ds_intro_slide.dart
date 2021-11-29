import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DSIntroSlide extends StatelessWidget {
  final String title;
  final String description;
  final String pathImage;
  const DSIntroSlide({
    Key? key,
    required this.title,
    required this.description,
    required this.pathImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
      child: Container(
        color: Colors.white,
        width: SizeConfig.screenWidth - kDefaultHorizontalPadding * 2,
        child: Padding(
          padding: const EdgeInsets.only(top: 140),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      title,
                      style: DSTextStyles.bold26black,
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: SvgPicture.asset(
                      pathImage,

                      width: SizeConfig.screenWidth -
                          kDefaultHorizontalPadding * 2,
                      // height: 220,
                    ),
                  ),
                  // Image.asset(
                  //   pathImage,
                  //   width: 220,
                  //   height: 220,
                  // ),
                  SizedBox(height: 100),
                  Expanded(
                    flex: 2,
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: DSTextStyles.regular14Black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
