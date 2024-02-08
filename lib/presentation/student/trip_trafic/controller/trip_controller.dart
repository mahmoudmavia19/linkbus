

import 'dart:async';

import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../../../../core/app_export.dart';

class TripTraficController extends GetxController {
  RxString timer = "".obs;
  final Rx<LocationData> currentLocation_ = Rx(LocationData.fromMap({}));
  late GoogleMapController mapController ;


  reTest(){
    _timerTest();
  }

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }
  @override
  void onInit() {
    _timerTest();
     super.onInit();
  }

  _timerTest(){
    var startTrip = DateTime(0,0,0,0,0,20);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      this.timer.value = DateFormat.ms().format(startTrip.subtract(Duration(seconds: timer.tick)));
      print(timer.tick);
      if( timer.tick == 3 ){
        Get.snackbar('Bus Notification', 'Your bus has start trip',duration: Duration(seconds: 2),
        onTap: (snack) {
          Get.closeAllSnackbars();
        },);
      }else if (timer.tick == 10){
        Get.snackbar('Bus Notification', 'Your bus has Very close ',duration: Duration(seconds: 2),
          onTap: (snack) {
            Get.closeAllSnackbars();
          },);
      }
      else if (timer.tick == 20){
        Get.snackbar('Bus Notification', 'Your bus has arrived',duration: Duration(seconds : 2),
          onTap: (snack) {
            Get.closeAllSnackbars();
          },);
        timer.cancel();
      }
    });
  }
}