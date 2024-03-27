 import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linkbus/data/models/driver.dart';
import 'package:linkbus/data/remote_date_source/remote_data_source.dart';
import 'package:location/location.dart';

import '../../../../core/app_export.dart';
 import 'package:geocoding/geocoding.dart' as geocoding;

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
class DriverMyLocationController extends GetxController {
  RxString address = "".obs;
  final Rx<LocationData> currentLocation_ = Rx(LocationData.fromMap({}));
  late GoogleMapController mapController ;
  DriverRemoteDataSource driverRemoteDataSource = DriverRemoteDataSourceImpl(Get.find(), Get.find());

  Rx<FlowState> state = Rx(ContentState());
  Driver? driver ;
  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }
  @override
  void onInit() async{
    _getCurrentLocation();
    await getDriver();
    super.onInit();
  }

  getDriver() async {
    state.value = LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    (await driverRemoteDataSource.getDriver()).fold(
            (l) {
          state.value = ErrorState(
              StateRendererType.popupErrorState,
              l.message);
        },
            (r) {
          driver = r;
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
    driver?.location = LatLng(currentLocation_.value.latitude!,currentLocation_.value.longitude!);
    driver?.address = address.value;
    driver = Driver(uid: driver?.uid, email: driver?.email, location:LatLng(currentLocation_.value.latitude!,currentLocation_.value.longitude!),address: address.value);
    print(driver?.location);
    (await driverRemoteDataSource.saveMyLocation(driver!)).fold(
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