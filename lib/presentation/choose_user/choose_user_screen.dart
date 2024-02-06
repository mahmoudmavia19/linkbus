import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/app_export.dart';
import '../../core/utils/app_strings.dart';

class ChooseUserScreen extends StatefulWidget {
  @override
  State<ChooseUserScreen> createState() => _ChooseUserScreenState();
}

class _ChooseUserScreenState extends State<ChooseUserScreen> {
  RxBool show = false.obs;

  @override
  void initState() {
    Timer.periodic(
      Duration(milliseconds: 1000),
      (timer) {
        show.value = !show.value;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          AppStrings.welcomeTo,
          style: theme.textTheme.headlineMedium,
        ),
        CustomImageView(
          imagePath: ImageConstant.imgLogo,
          width: 300.0,
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 300.0,
          height: 50.0,
          child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.studentLoginScreen);
              },
              child: Text(AppStrings.student)),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 300.0,
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.driverLoginScreen);
            },
            child: Text(AppStrings.driver),
            style: ButtonStyle(),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Lottie.asset(
          AppLottie.hand,
          width: 150.0,
        ),
      ]),
    ));
  }
}
