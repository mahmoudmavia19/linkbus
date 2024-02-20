import 'package:flutter/material.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/presentation/driver/mylocation_management/mylocation_management_screen.dart';
import 'package:linkbus/presentation/driver/trip_trafic/trip_trafic_screen.dart';
import 'package:linkbus/presentation/driver/trips/driver_trips_screen.dart';

class DriverMainController extends GetxController {
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;

  List<Widget> get screens => [
   DriverTripsScreen(),
   DriverTripTraficScreen(),
   DriverLocationManagementScreen()
  ];

}