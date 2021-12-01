import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/02_map/components/ds_intro_slide.dart';
import 'package:dongnesosik/pages/02_map/components/ds_last_slide.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class PageIntroSlider extends StatefulWidget {
  const PageIntroSlider({Key? key}) : super(key: key);

  @override
  _PageIntroSliderState createState() => _PageIntroSliderState();
}

class _PageIntroSliderState extends State<PageIntroSlider> {
  double _currentPage = 0;
  bool _showButton = false;
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (value) => _onPageChanged(value),
            children: [
              DSIntroSlide(
                title: '홍보하세요.',
                description: '동네 사람들에게 가게를 홍보하세요.',
                pathImage: "assets/images/intro1.svg",
              ),
              DSIntroSlide(
                title: '대화하세요.',
                description: '동네 사람들과 대화하세요.',
                pathImage: "assets/images/intro2.svg",
              ),
              DSIntroSlide(
                title: '공유하세요.',
                description: '동네 소식을 주변사람들에게 공유하세요.',
                pathImage: "assets/images/intro3.svg",
              ),
              DSLastSlide(),
            ],
          ),
          _showButton
              ? Positioned(
                  left: 20,
                  bottom: 30,
                  child: DSButton(
                      width: MediaQuery.of(context).size.width - 40,
                      text: '닫기',
                      press: () {
                        Navigator.of(context).pop();
                      }),
                )
              : Stack(
                  children: [
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      bottom: 17,
                      height: 40,
                      child: Container(
                        child: DotsIndicator(
                          decorator:
                              DotsDecorator(activeColor: DSColors.tomato),
                          dotsCount: 4,
                          position: _currentPage,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 18,
                      bottom: 17,
                      height: 40,
                      child: TextButton(
                        child: Text(
                          "SKIP",
                          style: DSTextStyles.bold16Black,
                        ),
                        onPressed: () => _onSkip(),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  _onPageChanged(int page) {
    setState(() {
      _currentPage = page.toDouble();
      _showButton = page == 3;
    });
  }

  _onSkip() {
    _pageController.jumpToPage(3);
  }
}
