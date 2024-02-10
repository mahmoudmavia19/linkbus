import 'dart:async';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/app_export.dart';


/// A controller class for the SplashScreen.
///
/// This class manages the state of the SplashScreen, including the
/// current splashModelObj
class SplashController extends GetxController {

  @override
  void onInit() {
    Timer(Duration(seconds: 3), () {
    Get.offAllNamed(AppRoutes.onBoardingScreen);
    });
    super.onInit();
  }
}
