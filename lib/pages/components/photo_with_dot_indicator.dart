// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dongnesosik/global/style/constants.dart';
// import 'package:dongnesosik/global/style/dscolors.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';

// class PhotoWithDotIndicator extends StatefulWidget {
//   const PhotoWithDotIndicator(
//       {required List<String> imageUrls, double? height, Key? key})
//       : _imageUrls = imageUrls,
//         _height = height,
//         super(key: key);

//   final List<String> _imageUrls;
//   final double? _height;

//   @override
//   _PhotoWithDotIndicatorState createState() => _PhotoWithDotIndicatorState();
// }

// class _PhotoWithDotIndicatorState extends State<PhotoWithDotIndicator> {
//   double currentBannerIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);

//     return widget._imageUrls.length == 0
//         ? SizedBox.shrink()
//         : Container(
//             width: SizeConfig.screenWidth,
//             height: SizeConfig.screenWidth * 0.7,
//             child: Stack(
//               children: <Widget>[
//                 PageView.builder(
//                   itemCount: widget._imageUrls.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.of(context).pushNamed('PhotoViewer',
//                             arguments: widget._imageUrls[index]);
//                       },
//                       child: Container(
//                         child: CachedNetworkImage(
//                           imageUrl: widget._imageUrls[index],
//                           fit: BoxFit.cover,
//                           errorWidget: (BuildContext, String, dynamic) {
//                             return Container(child: Text('이미지를 불러오지 못했습니다.'));
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                   onPageChanged: (page) {
//                     setState(() {
//                       currentBannerIndex = page.toDouble();
//                     });
//                   },
//                 ),
//                 Positioned(
//                   bottom: 8,
//                   right: 10,
//                   left: 10,
//                   child: DotsIndicator(
//                     dotsCount: widget._imageUrls.length,
//                     position: currentBannerIndex,
//                     decorator: DotsDecorator(
//                       size: Size(8, 8),
//                       activeSize: Size(8, 8),
//                       color: Colors.white,
//                       activeColor: DSColors.tomato,
//                       spacing: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//   }
// }
