import 'package:linkbus/core/app_export.dart';

class DriverTripsController extends GetxController {
    RxBool startTrip = false.obs;

    toggleStartTrip(){
      startTrip.value = !startTrip.value;
    }
}