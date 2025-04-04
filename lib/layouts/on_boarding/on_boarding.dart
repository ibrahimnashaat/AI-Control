import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/color.dart';
import '../login/login.dart';

class Swiping {
  late final String image;
  late final String text1;
  late final String text2;

  Swiping({required this.image, required this.text1, required this.text2});
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<Swiping> swipingScreens = [
    Swiping(
        image: 'assets/images/13.png',
        text1: 'Disease Detection',
        text2:
            'This application helps you in early detection of diseases that may cause great harm in the future without your knowledge.'),
    Swiping(
        image: 'assets/images/14.png',
        text1: 'Health Status',
        text2:
            'The application allows you to follow up on your condition periodically, and see if there is an improvement or not.'),
    Swiping(
        image: 'assets/images/20.png',
        text1: 'Doctor\'s Instructions',
        text2:
            'The application allows you to download your medical information, and send it to the doctor to be examined for you.'),
  ];

  var pageController = PageController();
  bool isLast = false;

  void submit() {
    cachHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value != null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
        ),
        actions: [
          SizedBox(
            width: 24,
            child: TextButton(
              onPressed: submit,
              child: Text(
                'SKIP',
                style: TextStyle(
                    color: mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == swipingScreens.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  controller: pageController,
                  itemBuilder: (context, index) =>
                      onBoarding(swipingScreens[index]),
                  itemCount: swipingScreens.length,
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: swipingScreens.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.black26,
                      activeDotColor: mainColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 3,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 50,
                    child: FloatingActionButton(
                      onPressed: () {
                        if (isLast) {
                          submit();
                        } else {
                          pageController.nextPage(
                              duration: Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }
                      },
                      backgroundColor: mainColor,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 26,
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget onBoarding(Swiping wid) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            '${wid.image}',

          ),
          Text(
            '${wid.text1}',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: HexColor('#1D2445'),
                letterSpacing: 2),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Text(
              '${wid.text2}',
              //      'I have developed meaningful relationships with individuals of all ages, including seven-year-old Hillary. Many of my mentees come from disadvantaged backgrounds',
              textAlign: TextAlign.center,

              style: TextStyle(
                color: Colors.black54,
                fontSize: 16
              ),
            ),
          ),
        ],
      );
}
