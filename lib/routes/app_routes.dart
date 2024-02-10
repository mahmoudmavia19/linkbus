
import 'package:get/get.dart';
import 'package:linkbus/presentation/choose_user/choose_user_screen.dart';
import 'package:linkbus/presentation/splash_screen/binding/splash_binding.dart';
import 'package:linkbus/presentation/splash_screen/splash_screen.dart';
import 'package:linkbus/presentation/student/auth/login/binding/student_login_binding.dart';
import 'package:linkbus/presentation/student/auth/login/student_login_screen.dart';

import '../presentation/driver/auth/login/binding/driver_login_binding.dart';
import '../presentation/driver/auth/login/driver_login_screen.dart';
import '../presentation/onboarding/onboarding_screen.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String chooseUserTypeScreen = '/chooseUserTypeScreen';
  static const String  studentLoginScreen = '/student/studentLoginScreen';
  static const String  driverLoginScreen = '/driver/driverLoginScreen';
  static List<GetPage> pages = [
    GetPage (
      name:initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage (
      name:onBoardingScreen,
      page: () => OnBoardingScreen(),
    ),
    GetPage (
      name:chooseUserTypeScreen,
      page: () => ChooseUserScreen(),
    ),
    GetPage (
      name:studentLoginScreen,
      page: () => StudentLoginPage(),
      binding: StudentLoginBinding()
    ),
    GetPage (
      name:driverLoginScreen,
      page: () => DriverLoginPage(),
      binding: DriverLoginBinding()
    )
  ];
}
