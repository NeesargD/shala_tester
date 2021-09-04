import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/ui/Intro/data.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final CarouselController _carouselController = CarouselController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorRes.primaryColor,
        body: Stack(
          children: [
            CarouselSlider.builder(
              itemCount: splashScreenList.length,
              carouselController: _carouselController,
              options: CarouselOptions(
                onPageChanged: (index, realIndex) {
                  setState(() {
                    currentPage = index;
                  });
                },
                viewportFraction: 1,
                height: MediaQuery.of(context).size.height,
                autoPlay: true,
                enableInfiniteScroll: false,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          splashScreenList[index].image,
                          // width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height * 0.4,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          splashScreenList[index].title,
                          style: TextStyle(color: ColorRes.white, fontSize: 50, letterSpacing: 0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          splashScreenList[index].subTitle,
                          style: TextStyle(letterSpacing: 0, fontSize: 30, color: ColorRes.white),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.13,
                      )
                    ],
                  ),
                );
              },
            ),
            PositionedDirectional(
              bottom: 20,
              start: 0,
              end: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: splashScreenList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: Container(
                      height: 8,
                      width: 8,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: (currentPage == entry.key ? ColorRes.white : ColorRes.indicatorColor),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
