import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/presentation/driver/trips/controller/driver_trips_controller.dart';

class DriverTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriverTripsController());
  }
}