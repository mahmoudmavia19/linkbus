 import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer.dart';
import 'package:linkbus/data/models/passenger.dart';
import 'package:linkbus/data/remote_date_source/passenger_remote_data_source.dart';
import 'package:location/location.dart';

import '../../../../core/app_export.dart';
 import 'package:geocoding/geocoding.dart' as geocoding;
 import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
class MyLocationController extends GetxController {
  RxString address = "".obs;
   final Rx<LocationData> currentLocation_ = Rx(LocationData.fromMap({}));
  late GoogleMapController mapController ;
  PassengerRemoteDataSource passengerRemoteDataSource = PassengerRemoteDataSourceImpl(Get.find(), Get.find());

  Rx<FlowState> state = Rx(ContentState());
  Passenger? passenger ;
  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }
  @override
  void onInit() async{
     _getCurrentLocation();
    await getPassenger();
    super.onInit();
  }

  getPassenger() async {
    state.value = LoadingState(stateRendererType: StateRendererType.popupLoadingState);
      (await passengerRemoteDataSource.getPassenger()).fold(
            (l) {
              state.value = ErrorState(
                  StateRendererType.popupErrorState,
                  l.message);
            },
            (r) {
              passenger = r;
              currentLocation_.value = LocationData.fromMap({
                'latitude': r.location?.latitude,
                'longitude': r.location?.longitude
              });
              address.value = r.address??"";
              state.value = ContentState();
            });
  }

  chooseLocation(LatLng target ) {
    currentLocation_.value = LocationData.fromMap({
      'latitude': target.latitude,
      'longitude': target.longitude
    });
    getAddressFromCoordinates(LatLng(currentLocation_.value.latitude!,
        currentLocation_.value.longitude!));
  }
  Future<void> _getCurrentLocation() async {
    Location location = Location();
    LocationData currentLocation = await location.getLocation();
    currentLocation_.value = currentLocation;
  }

  Future<void> getAddressFromCoordinates(LatLng latlng) async {
    try {
      List<geocoding.Placemark> placemarks =
      await geocoding.placemarkFromCoordinates(latlng.latitude,latlng.longitude);

      if (placemarks.isNotEmpty) {
        geocoding.Placemark placemark = placemarks[0];
        print(
            "${placemark.street}, ${placemark.locality}, ${placemark.country}");
        address.value = "${placemark.street},\n ${placemark.locality},\n ${placemark.country}";
      } else {
        print('No address found');
      }
    } catch (e) {
      print("Error: $e");
      print('Error getting address');
    }
  }

  saveMyLocation() async {
    state.value = LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    passenger?.location = LatLng(currentLocation_.value.latitude!,currentLocation_.value.longitude!);
    passenger?.address = address.value;
    passenger = Passenger(uid: passenger?.uid, email: passenger?.email, location:LatLng(currentLocation_.value.latitude!,currentLocation_.value.longitude!),address: address.value);
    print(passenger?.location);
    (await passengerRemoteDataSource.saveMyLocation(passenger!)).fold(
            (l) {
              state.value = ErrorState(
                  StateRendererType.popupErrorState,
                  l.message
              );
            },
            (r){
              state.value = ContentState();
            }
        );

  }

 }