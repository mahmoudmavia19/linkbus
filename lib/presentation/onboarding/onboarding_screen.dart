import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/core/constants/constant.dart';
import 'package:linkbus/presentation/onboarding/onboarding_page.dart';
import 'package:lottie/lottie.dart';

import 'model/page_data.dart';

class OnBoardingScreen extends StatelessWidget {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ConcentricPageView(
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
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: OnBoardingPage(page: page),
          );
        },
      ),
    );
  }
}
