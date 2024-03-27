import 'package:flutter/animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:linkbus/data/models/driver.dart';
import 'package:linkbus/data/models/trip.dart';
import 'package:linkbus/data/remote_date_source/remote_data_source.dart';
import 'package:linkbus/presentation/driver/main/controller/main_controller.dart';
import 'package:location/location.dart';

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../data/models/notification.dart';
import '../../trip_trafic/controller/trip_controller.dart';

class DriverTripsController extends GetxController {
    RxBool startTrip = false.obs;
    DriverRemoteDataSource remoteDataSource = Get.find<DriverRemoteDataSourceImpl>();
    Rx<FlowState> state = Rx(LoadingState(stateRendererType:StateRendererType.fullScreenLoadingState));
    DriverMainController driverMainController = Get.find();
    DriverTripTraficController driverTripTraficController = Get.find();
    List<Trip> trips = [];
    Rx<Trip?> trip = Rx<Trip?>(null);
    Rx<Driver?> driver = Rx<Driver?>(null);
    toggleStartTrip(){
      startTrip.value = !startTrip.value;
    }

    sendNotification(Trip trip,Notification notification)async {
      (await remoteDataSource.sendNotification(trip,notification)).fold((failure) {

      }, (result) {

      });
    }

    updateTripIsStarted(bool start)async{
      trip.value!.started  = start ;
      (await remoteDataSource.updateTrip(trip.value!)).fold((failure) {

      }, (result) {
        if(!start){
          sendNotification(trip.value!, Notification(dateTime: DateTime.now(), message: 'Trip , ${trip.value!.title}  ended'));
          trip.value = null ;
        }
      });
    }
    startTripVoid(Trip trip){
      this.trip.value = trip;
      updateTripIsStarted(true);
      sendNotification(trip, Notification(dateTime: DateTime.now(), message: 'Trip , ${trip.title}  started'));
      driverTripTraficController.startLocation.value =LocationData.fromMap({
        'latitude': trip.startLocation!.latitude,
        'longitude': trip.startLocation!.longitude,
      }) ;
      driverTripTraficController.endLocation.value =LocationData.fromMap({
        'latitude': trip.endLocation!.latitude,
        'longitude': trip.endLocation!.longitude,
      }) ;
      driverTripTraficController.getPassengerForTrip(trip.uid);
      driverTripTraficController.getPolyPoints();
      driverTripTraficController.isTripStarted.value = true;
      driverTripTraficController.getCurrentLocation();
      driverMainController.pageController.animateToPage(1, duration: Duration(seconds: 1), curve: Curves.bounceIn);
    }

    Future<void> getDriver()async{
      ( await remoteDataSource.getDriver()).fold((failure) {

      }, (result) {
        driver.value = result;
      }) ;
    }
    @override
  void onReady() {
    super.onReady();

  }
    @override
    onInit() async{
      await getTrips();
      await getDriver() ;
      super.onInit();
    }

    getTrips() async{
      state.value = LoadingState(stateRendererType:StateRendererType.fullScreenLoadingState);
      (await remoteDataSource.getTrips()).fold((failure) {
        state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
      }, (result) {
        trips = result;
        state.value = ContentState();
      });
    }


}