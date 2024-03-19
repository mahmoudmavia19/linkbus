
import 'package:get/get.dart';
import 'package:linkbus/presentation/choose_user/choose_user_screen.dart';
import 'package:linkbus/presentation/driver/mylocation_management/binding/my_location_binding.dart';
import 'package:linkbus/presentation/driver/trip_trafic/binding/trip_binding.dart';
import 'package:linkbus/presentation/driver/trips/binding/driver_trips_binding.dart';
import 'package:linkbus/presentation/splash_screen/binding/splash_binding.dart';
import 'package:linkbus/presentation/splash_screen/splash_screen.dart';
import 'package:linkbus/presentation/student/auth/login/binding/student_login_binding.dart';
import 'package:linkbus/presentation/student/auth/login/student_login_screen.dart';
import 'package:linkbus/presentation/student/home_screen/binding/home_binding.dart';
import 'package:linkbus/presentation/student/mylocation_management/binding/my_location_binding.dart';
import 'package:linkbus/presentation/student/mylocation_management/mylocation_management_screen.dart';
import 'package:linkbus/presentation/student/notification/binding/notification_binding.dart';
import 'package:linkbus/presentation/student/trip_trafic/binding/trip_binding.dart';

import '../presentation/driver/auth/login/binding/driver_login_binding.dart';
import '../presentation/driver/auth/login/driver_login_screen.dart';
import '../presentation/driver/help_screen/driver_help_screen.dart';
import '../presentation/driver/main/binding/main_binding.dart';
import '../presentation/driver/main/main_screen.dart';
import '../presentation/onboarding/onboarding_screen.dart';
import '../presentation/student/help_screen/binding/help_binding.dart';
import '../presentation/student/help_screen/help_screen.dart';
import '../presentation/student/main/binding/main_binding.dart';
import '../presentation/student/main/main_screen.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String chooseUserTypeScreen = '/chooseUserTypeScreen';
  static const String  studentLoginScreen = '/student/studentLoginScreen';
  static const String  driverLoginScreen = '/driver/driverLoginScreen';
  static const String  studentMyLocationScreen = '/student/studentMyLocationScreen';
  static const String  studentMainScreen = '/student/studentMainScreen';
  static const String  studentHelpScreen = '/student/studentHelpScreen';
  // driver routes
  static const String  driverMainScreen = '/driver/driverMainScreen';
  static const String  driverHelpScreen = '/driver/driverHelpScreen';

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
    ),
    GetPage (
      name:studentMyLocationScreen,
      page: () => MyLocationManagementScreen(),
      binding: MyLocationBinding()
    ),
     GetPage (
      name:studentMainScreen,
      page: () => MainScreen(),
      bindings:[
        MainBinding(),
        HomeBinding(),
        MyLocationBinding(),
        TripBinding(),
        NotificationBinding(),
      ]
     ),
    GetPage (
      name:studentHelpScreen,
      page: () => HelpScreen(),
      binding: HelpBinding()
    ),
    GetPage(
      name:driverMainScreen,
      page: () => DriverMainScreen(),
      bindings:[
        DriverMainBinding(),
        DriverTripsBinding(),
        DriverMyLocationBinding(),
        DriverTripTraficBinding()
       ]
    ),
    GetPage (
      name:driverHelpScreen,
      page: () => DriverHelpScreen(),
      binding: HelpBinding()
    )
  ];
}
