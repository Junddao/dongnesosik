import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class DSCarousel extends StatefulWidget {
  DSCarousel({
    // required this.size,
    Key? key,
    required this.iamgeUrls,
    this.press,
    this.screenHeight = 200,
  }) : super(key: key);

  final List<String> iamgeUrls;
  final Function? press;
  final double? screenHeight;

  @override
  State<DSCarousel> createState() => _DSCarouselState();
}

class _DSCarouselState extends State<DSCarousel> {
  CarouselController buttonCarouselController = CarouselController();
  double currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return widget.iamgeUrls.length == 0
        ? SizedBox.shrink()
        : Stack(
            children: <Widget>[
              CarouselSlider.builder(
                itemCount: widget.iamgeUrls.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return InkWell(
                    onTap: () {
                      widget.press;
                    },
                    child: CachedNetworkImage(
                      imageUrl: widget.iamgeUrls[itemIndex],
                      fit: BoxFit.cover,
                      errorWidget: (BuildContext, String, dynamic) {
                        return Container(child: Text('이미지를 불러오지 못했습니다.'));
                      },
                    ),
                    // child: ClipRRect(
                    //   // borderRadius: BorderRadius.circular(20),
                    //   child:
                    // ),
                  );
                },
                options: CarouselOptions(
                    height: widget.screenHeight,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    // aspectRatio: 327 / 150,
                    initialPage: 0,
                    onPageChanged: (page, _) {
                      setState(() {
                        currentBannerIndex = page.toDouble();
                      });
                    }),
              ),
              Positioned(
                bottom: 8,
                right: 10,
                left: 10,
                child: DotsIndicator(
                  dotsCount: widget.iamgeUrls.length,
                  position: currentBannerIndex,
                  decorator: DotsDecorator(
                    size: Size(8, 8),
                    activeSize: Size(8, 8),
                    color: Colors.white,
                    activeColor: DSColors.tomato,
                    spacing: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                  ),
                ),
              )
            ],
          );
  }
}
