import 'dart:async';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../../core/app_export.dart';
import '../../../../core/constants/constant.dart';

class DriverTripTraficController extends GetxController {
  RxString timer = "".obs;
  RxString newDistance = "".obs;
  final Rx<LocationData> currentLocation_ = Rx(LocationData.fromMap({}));
  late GoogleMapController mapController ;

  final Rx<LocationData> startLocation = Rx(LocationData.fromMap({
    'latitude': startMapLocation.latitude,
    'longitude': startMapLocation.longitude,
  }));
  final Rx<LocationData> endLocation = Rx(LocationData.fromMap({
    'latitude': startMapLocation.latitude + 0.005,
    'longitude': startMapLocation.longitude + 0.005,
  }));
  List<LatLng> polylineCoordinates = [];

  reTest(){
/*
    _timerTest();
*/
    startUpdatingLocations();
  }

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }
  @override
  void onInit() {
    getPolyPoints();
/*
    _timerTest();
*/
     super.onInit();
  }


  void startUpdatingLocations() {
    startLocation.value = LocationData.fromMap({
      'latitude': startMapLocation.latitude,
      'longitude': startMapLocation.longitude,
    });
    Get.snackbar('Trip Alert', 'Trip started');
    Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      updateLocations(timer);
      print(startLocation.value);
      print('start');

    });
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371000; // in meters

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = degreesToRadians(point1.latitude);
    double lon1Rad = degreesToRadians(point1.longitude);
    double lat2Rad = degreesToRadians(point2.latitude);
    double lon2Rad = degreesToRadians(point2.longitude);

    // Haversine formula
    double deltaLat = lat2Rad - lat1Rad;
    double deltaLon = lon2Rad - lon1Rad;
    double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(deltaLon / 2) * sin(deltaLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    newDistance.value = distance.toInt().toString();
    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }


  void updateLocations(Timer timer) {
    // Update start location coordinates (move towards end location)
    if (startLocation.value.latitude! < endLocation.value.latitude!) {
      startLocation.value = LocationData.fromMap({
        'latitude': startLocation.value.latitude! + 0.0001,
        'longitude': startLocation.value.longitude! + 0.0001,
      });
     // print(calculateDistance(LatLng(startLocation.value.latitude!, startLocation.value.longitude!), LatLng(endLocation.value.latitude!, endLocation.value.longitude!)));
      if(calculateDistance(LatLng(startLocation.value.latitude!, startLocation.value.longitude!), LatLng(endLocation.value.latitude!, endLocation.value.longitude!)) == 105.13223958075635){
        Get. snackbar('Trip Alert', 'Trip very close');
      }
      calculateTravelTime(LatLng(startLocation.value.latitude!, startLocation.value.longitude!), LatLng(endLocation.value.latitude!, endLocation.value.longitude!));
    }   else {
      // Stop the timer when the end point is reached
      Get. snackbar('Trip Alert', 'Trip ended');
      newDistance.value = "0";
      this.timer.value = "0h 0m 0s";
      timer.cancel();
    }

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: LatLng(startLocation.value.latitude!, startLocation.value.longitude!),
        ),
      ),
    );
    update();
  }

  void getPolyPoints() {
    polylineCoordinates.add(LatLng(startLocation.value.latitude!, startLocation.value.longitude!));
    polylineCoordinates.add(LatLng(endLocation.value.latitude!, endLocation.value.longitude!));
  }


  // Assuming an average speed of 60 kilometers per hour
  double averageSpeedKph = 60.0;

// Function to calculate the time taken to travel between two points
  void calculateTravelTime(LatLng point1, LatLng point2) {
    double distanceKm = calculateDistance(point1, point2) / 1000; // Convert meters to kilometers
    double travelTimeHours = distanceKm / averageSpeedKph;
    int totalSeconds = (travelTimeHours * 3600).round();

    int hours = totalSeconds ~/ 3600;
    int remainingSeconds = totalSeconds % 3600;
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;

    timer.value =  '${hours}h ${minutes}m ${seconds}s';
  }

}