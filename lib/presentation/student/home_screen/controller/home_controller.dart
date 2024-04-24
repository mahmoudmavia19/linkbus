
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:linkbus/data/models/passenger.dart';
import 'package:linkbus/data/models/trip.dart';
import 'package:linkbus/data/remote_date_source/passenger_remote_data_source.dart';
import 'package:linkbus/presentation/student/trip_trafic/controller/trip_controller.dart';
import 'package:location/location.dart';

import '../../../../core/app_export.dart';

class HomeController extends GetxController {
  Rx<FlowState> state = Rx(LoadingState(stateRendererType:StateRendererType.fullScreenLoadingState));
  PassengerRemoteDataSource remoteDataSource = Get.find<PassengerRemoteDataSourceImpl>() ;
  RxList<Trip> trips = <Trip>[].obs;
  Passenger? passenger ;

  onInit() async{
    await getPassenger();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message received");
      print(event.notification!.body);
      Get.dialog(AlertDialog(
          title:Text('Notification'),
          content:
          Text(event.notification!.body!)));
      getTrips();
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      getTrips();
    });
    super.onInit();
  }

  getPassenger() async{
    state.value = LoadingState(stateRendererType:StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getPassenger()).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (result) async{
      passenger = result;
      FirebaseMessaging.instance.subscribeToTopic(passenger!.uid!);
      await getTrips();
     });
  }

  updateTrip(Trip trip) async{
    if(trip.selected){
      trip.passengers.add(passenger!.uid!);
      FirebaseMessaging.instance.subscribeToTopic(trip.uid!);
    }
    else{
      trip.passengers.remove(passenger!.uid!);
      FirebaseMessaging.instance.unsubscribeFromTopic(trip.uid!);
    }
    print(trip.toJson());
    print(trip.selected);
    state.value = LoadingState(stateRendererType:StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.updateTrip(trip)).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (result) {

      state.value = ContentState();
    }) ;
  }
  getTrips () async{
     (await remoteDataSource.getTrips()).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (result) {
      result.forEach((element)async {
        element.selected = element.passengers.contains(passenger?.uid);
        trips.value = result;
        if(element.started) {
          Get
              .find<TripTraficController>()
              .trip
              .value = element;
          Get.find<TripTraficController>().startLocation .value =LocationData.fromMap({
            'latitude': element.startLocation!.latitude,
            'longitude': element.startLocation!.longitude,
          });
          Get.find<TripTraficController>().endLocation.value =LocationData.fromMap({
            'latitude': element.endLocation!.latitude,
            'longitude': element.endLocation!.longitude,
          });

          await Get.find<TripTraficController>().getPolyLinesForPassenger(passenger!);
     //     await Get.find<TripTraficController>().getPolyPoints();
          await Get.find<TripTraficController>().startDriverTracking(passenger!);

        }
      });
      state.value = ContentState();
    });
  }
}