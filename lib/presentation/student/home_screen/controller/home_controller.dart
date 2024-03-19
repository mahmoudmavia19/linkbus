
import 'package:linkbus/core/utils/state_renderer/state_renderer.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:linkbus/data/models/passenger.dart';
import 'package:linkbus/data/models/trip.dart';
import 'package:linkbus/data/remote_date_source/passenger_remote_data_source.dart';

import '../../../../core/app_export.dart';

class HomeController extends GetxController {
  Rx<FlowState> state = Rx(LoadingState(stateRendererType:StateRendererType.fullScreenLoadingState));
  PassengerRemoteDataSource remoteDataSource = Get.find<PassengerRemoteDataSourceImpl>() ;
  RxList<Trip> trips = <Trip>[].obs;
  Passenger? passenger ;

  onInit() async{
    await getPassenger();
    super.onInit();
  }

  getPassenger() async{
    state.value = LoadingState(stateRendererType:StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getPassenger()).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (result) async{
      passenger = result;
      await getTrips();
     });
  }

  updateTrip(Trip trip) async{
    if(trip.selected){
      trip.passengers.add(passenger!.uid!);
    }
    else{
      trip.passengers.remove(passenger!.uid!);
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
      result.forEach((element) {
        element.selected = element.passengers.contains(passenger?.uid);
        trips.add(element);
      });
      state.value = ContentState();
    });
  }
}