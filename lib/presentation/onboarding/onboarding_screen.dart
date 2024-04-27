import 'package:flutter/material.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/core/constants/constant.dart';
import 'package:linkbus/presentation/onboarding/intro_onbording_plus.dart';
import 'package:linkbus/presentation/onboarding/introduction_plus.dart';

class OnBoardingScreen extends StatelessWidget {

  final List<IntroductionPlus> list = [
    IntroductionPlus(
      title:  "Welcome to\nLinkBus",
      subTitle: '',
      imageUrl: ImageConstant.imgLogo,
      isLotte: false,
    ),
    IntroductionPlus(
      title:  "Real-time Location Tracking and Notifications",
      subTitle:'',
      imageUrl: AppLottie.traking,
    ),
    IntroductionPlus(
      title: "Trip Management and Scheduling",
      subTitle: '',
      imageUrl: AppLottie.scheduling
    ),
    IntroductionPlus(
      title:  "Optimized Route Planning for Drivers",
      subTitle: '',
      imageUrl: AppLottie.driver,
    ),
  ];

  bool flag = false ;

  Rx<Color> color = Rx<Color>(appColorsDigress[0]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:Obx(
         ()=> IntroScreenOnboardingPlus(
           skipTextStyle: const TextStyle(fontSize: 20,color: Colors.black),
           backgroudColor: color.value,
          introductionList: list,
          onPageChanged: (p0) {
             color.value = appColorsDigress[p0];
            print(p0);
          },
          onTapSkipButton: () {
            Get.toNamed(AppRoutes.chooseUserTypeScreen);
          },
               ),
       )
    );
  }
}

/*
final pages = [
    PageData(
      icon: Image.asset(ImageConstant.imgLogo),
      title: "Welcome to\nLinkBus",
      bgColor: appColorsDigress[0],
      textColor: Colors.black,
    ),
      PageData(
        icon: Lottie.asset(AppLottie.traking),
      title: "Real-time Location Tracking and Notifications",
        bgColor: appColorsDigress[1],
        textColor: Colors.white,
    ),
      PageData(
        icon: Lottie.asset(AppLottie.scheduling),
      title: "Trip Management and Scheduling",
        textColor: Colors.white,
      bgColor: appColorsDigress[2],
    ),
      PageData(
        icon: Lottie.asset(AppLottie.driver),
      title: "Optimized Route Planning for Drivers",
      textColor: Colors.white,
      bgColor: appColorsDigress[3],
    ),
  ];
ConcentricPageView(
colors: pages.map((p) => p.bgColor).toList(),
radius: Get.width * 0.1,
// curve: Curves.ease,
nextButtonBuilder: (context) => Padding(
padding: const EdgeInsets.only(left: 3), // visual center
child: Icon(
Icons.navigate_next,
size: Get.width * 0.08,
),
),
onFinish: () {
Get.toNamed(AppRoutes.chooseUserTypeScreen);
},
itemCount: pages.length,
itemBuilder: (index) {
final page = pages[index % pages.length];
return SafeArea(
child: OnBoardingPage(page: page),
);
},
),*/
