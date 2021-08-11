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

 final  CarouselController _carouselController = CarouselController();

  int curretPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
          body: Column(
            children: [
              CarouselSlider.builder(
                itemCount: splashScreenList.length,
                carouselController: _carouselController,
                options: CarouselOptions(
                  onPageChanged: (index , realIndex){
                    setState(() {
                      curretPage = index;
                    });
                  },
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height * 0.9,
                  autoPlay: true,
                  enableInfiniteScroll: false,
                ),
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 30
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*0.5,
                            child: SvgPicture.asset(splashScreenList[index].image),
                          ),
                          Spacer(flex: 2),
                          Text(splashScreenList[index].title,style: TextStyle(
                              color: white,
                              fontSize: 50,
                            letterSpacing: 0
                          ),),
                          Text(splashScreenList[index].subTitle,
                            style: TextStyle( letterSpacing: 0,
                              fontSize: 30,
                              color: white
                          ),),
                         Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                         children: splashScreenList.asMap().entries.map((entry){
                            return GestureDetector(
                              onTap: () => _carouselController.animateToPage(entry.key),
                              child: Container(
                           height: 8,
                           width: 8,
                          margin: EdgeInsets.symmetric(
                                 vertical: 10.0, horizontal: 5.0),
                           decoration: BoxDecoration(
                               color: (curretPage == entry.key ?
                               white : indicatorColor),
                               shape: BoxShape.circle,
                           ),
                         ),
                            );
                         }).toList(),
                        ),
                        ],
                      ),
                    );
                  },
              ),
            ],
          ),
      ),
    );
  }
}