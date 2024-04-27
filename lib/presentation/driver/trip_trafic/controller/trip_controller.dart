import 'dart:async';
import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:linkbus/data/models/passenger.dart';
import 'package:linkbus/data/remote_date_source/remote_data_source.dart';
import 'package:location/location.dart';
import '../../../../core/app_export.dart';
import '../../../../core/constants/constant.dart';

class DriverTripTraficController extends GetxController {
  RxString timer = "".obs;
  RxString newDistance = "".obs;
  final Rx<LocationData> currentLocation_ = Rx(LocationData.fromMap({}));
  late GoogleMapController mapController ;
  RxBool isTripStarted = false.obs;
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    final  Rx<LocationData?> startLocation = Rx<LocationData?>(null);
    final Rx<LocationData?> endLocation = Rx<LocationData?>(null);
  List<LatLng> polylineCoordinates = [];
  RxList<Polyline> polyLines = <Polyline>[].obs;

  DriverRemoteDataSource driverRemoteDataSource = Get.find<DriverRemoteDataSourceImpl>();



  void getCurrentLocation() async {
    Get. snackbar('Trip Alert', 'Trip Started');

    Location location = Location();

     location.onLocationChanged.listen(
          (newLoc) {
            currentLocation_.value = newLoc;
            shareLocation(LatLng(newLoc.latitude!, newLoc.longitude!));
            if (newLoc.latitude! < endLocation.value!.latitude!) {

               if(calculateDistance(LatLng(newLoc.latitude!,newLoc.longitude!),
                  LatLng(endLocation.value!.latitude!,endLocation.value!.longitude!))== 20){
                Get. snackbar('Trip Alert', 'Trip very close');
              }
              calculateTravelTime(LatLng(newLoc.latitude!,newLoc.longitude!), LatLng(endLocation.value!.latitude!,endLocation.value!.longitude!));
            }   else if(calculateDistance(LatLng(newLoc.latitude!,newLoc.longitude!),
                LatLng(endLocation.value!.latitude!,endLocation.value!.longitude!))==0) {
              // Stop the timer when the end point is reached
              Get. snackbar('Trip Alert', 'Trip ended');
              isTripStarted.value = false;
              newDistance.value = "0";
              this.timer.value = "0h 0m 0s";
            }
/*
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: 19,
                  target: LatLng( currentLocation_.value.latitude!,  currentLocation_.value.longitude!),
                ),
              ),
            );*/


          },
    );
  }

  shareLocation(LatLng location)async{
    (await driverRemoteDataSource.shareMyLocation(location)).fold((l) {

    }, (r) {

    });
  }

  @override
  void onClose() {
    mapController.dispose();

    super.onClose();
  }
   @override
  void onReady() {
    super.onReady();
  }
  @override
  void onInit() {
     super.onInit();
  }
  RxList<Passenger> passengers = <Passenger>[].obs;
  getPassengerForTrip(tripID) async{
    state.value = LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    (await driverRemoteDataSource.getPassengerForTrip(tripID)).fold((l) {
      state.value = ErrorState(
        StateRendererType.popupErrorState,
        l.message
      );
    }, (r) async{
      passengers.value = r;
      Passenger? lastPassenger ;
      for(var passenger in passengers){
        // get random string ;
        var rSr  = Random().nextInt(1000).toString();
        if(passenger.uid == passengers.first.uid){
          var result = await getPolyLine(PointLatLng(startLocation.value!.latitude!,startLocation.value!.longitude!), PointLatLng(passenger.location!.latitude, passenger.location!.longitude),rSr) ;
          polyLines.add(result);

        }
        else {
          if(lastPassenger != null){
            var result = await getPolyLine( PointLatLng(lastPassenger.location!.latitude, lastPassenger.location!.longitude), PointLatLng(passenger.location!.latitude, passenger.location!.longitude),rSr) ;
            polyLines.add(result);
          }
        }
        lastPassenger = passenger;
      }
      var result = await getPolyLine( PointLatLng(lastPassenger!.location!.latitude, lastPassenger.location!.longitude),PointLatLng(endLocation.value!.latitude!,endLocation.value!.longitude!),'end') ;
      polyLines.add(result);
      print('----------${polyLines.length}----------------------');
      print('----------${passengers.length}----------------------');
      state.value = ContentState();
    });
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
    if (startLocation.value!.latitude! < endLocation.value!.latitude!) {
      startLocation.value = LocationData.fromMap({
        'latitude': startLocation.value!.latitude! + 0.0001,
        'longitude': startLocation.value!.longitude! + 0.0001,
      });
     // print(calculateDistance(LatLng(startLocation.value.latitude!, startLocation.value.longitude!), LatLng(endLocation.value.latitude!, endLocation.value.longitude!)));
      if(calculateDistance(LatLng(startLocation.value!.latitude!, startLocation.value!.longitude!), LatLng(endLocation.value!.latitude!, endLocation.value!.longitude!)) == 105.13223958075635){
        Get. snackbar('Trip Alert', 'Trip very close');
      }
      calculateTravelTime(LatLng(startLocation.value!.latitude!, startLocation.value!.longitude!), LatLng(endLocation.value!.latitude!, endLocation.value!.longitude!));
    }   else {
      // Stop the timer when the end point is reached
      Get. snackbar('Trip Alert', 'Trip ended');
      newDistance.value = "0";
      this.timer.value = "0h 0m 0s";
      timer.cancel();
    }

   /* mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: LatLng(startLocation.value!.latitude!, startLocation.value!.longitude!),
        ),
      ),
    );*/
    update();
  }
  void updateLocationsPlus() {
    // Update start location coordinates (move towards end location)
    if (startLocation.value!.latitude! < endLocation.value!.latitude!) {
      startLocation.value = LocationData.fromMap({
        'latitude': startLocation.value!.latitude! + 0.0001,
        'longitude': startLocation.value!.longitude! + 0.0001,
      });
      // print(calculateDistance(LatLng(startLocation.value.latitude!, startLocation.value.longitude!), LatLng(endLocation.value.latitude!, endLocation.value.longitude!)));
      if(calculateDistance(LatLng(startLocation.value!.latitude!, startLocation.value!.longitude!), LatLng(endLocation.value!.latitude!, endLocation.value!.longitude!)) == 105.13223958075635){
        Get. snackbar('Trip Alert', 'Trip very close');
      }
      calculateTravelTime(LatLng(startLocation.value!.latitude!, startLocation.value!.longitude!), LatLng(endLocation.value!.latitude!, endLocation.value!.longitude!));
    }   else {
      // Stop the timer when the end point is reached
      Get. snackbar('Trip Alert', 'Trip ended');
      newDistance.value = "0";
      this.timer.value = "0h 0m 0s";
    }

 /*   mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: LatLng(startLocation.value!.latitude!, startLocation.value!.longitude!),
        ),
      ),
    );*/
    update();
  }
  Future<void> getPolyPoints() async{
    PolylinePoints polylinePoints = PolylinePoints();
       PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDq7QPfERggjxVUMwB7khSou_0Ux7ujYVM', // Your Google Map Key
      PointLatLng(startLocation.value!.latitude!, startLocation.value!.longitude!),
      PointLatLng(endLocation.value!.latitude!, endLocation.value!.longitude!),
      optimizeWaypoints: true,
    );

     result.points.forEach(
          (PointLatLng point) => polylineCoordinates.add(
        LatLng(point.latitude, point.longitude),
      ),
    );
  }



  Future<Polyline> getPolyLine(PointLatLng start,PointLatLng end ,String id) async{
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDq7QPfERggjxVUMwB7khSou_0Ux7ujYVM', // Your Google Map Key
      start,
       end,
      optimizeWaypoints: true,
    );
   return Polyline(polylineId: PolylineId(id), points: result.points.map((e) => LatLng(e.latitude, e.longitude)).toList(), color: theme.primaryColor, width: 6);
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