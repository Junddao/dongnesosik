import 'package:cached_network_image/cached_network_image.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class DSPhotoView extends StatefulWidget {
  const DSPhotoView({
    Key? key,
    required this.iamgeUrls,
    this.screenHeight = 200,
  }) : super(key: key);

  final List<String> iamgeUrls;

  final double? screenHeight;

  @override
  _DSPhotoViewState createState() => _DSPhotoViewState();
}

class _DSPhotoViewState extends State<DSPhotoView> {
  double currentBannerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return widget.iamgeUrls.length == 0
        ? Container(
            width: double.infinity,
            height: widget.screenHeight,
            decoration: BoxDecoration(
              color: DSColors.greyish,
            ),
            child: Center(
                child: Text('No Image', style: DSTextStyles.bold14White)),
          )
        : Container(
            width: double.infinity,
            height: widget.screenHeight,
            child: Stack(
              children: <Widget>[
                PageView.builder(
                    itemCount: widget.iamgeUrls.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('DSPhotoViewer',
                              arguments: widget.iamgeUrls[index]);
                        },
                        child: CachedNetworkImage(
                          imageUrl: widget.iamgeUrls[index],
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
                    onPageChanged: (index) {
                      setState(() {
                        currentBannerIndex = index.toDouble();
                      });
                    }),
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
            ),
          );
  }
}
