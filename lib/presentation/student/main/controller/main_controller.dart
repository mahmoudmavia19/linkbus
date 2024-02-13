import 'package:flutter/cupertino.dart';
import 'package:linkbus/presentation/student/home_screen/home_screen.dart';
import 'package:linkbus/presentation/student/trip_trafic/trip_trafic_screen.dart';

import '../../../../core/app_export.dart';
import '../../mylocation_management/mylocation_management_screen.dart';
import '../../notification/notification_screen.dart';

class MainController extends GetxController {
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;

  List<Widget> get screens => [
    HomeScreen(),
    TripTraficScreen(),
    NotificationScreen(),
    MyLocationManagementScreen(),
  ];

}