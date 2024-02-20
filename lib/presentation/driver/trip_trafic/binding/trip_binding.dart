
import '../../../../core/app_export.dart';
import '../controller/trip_controller.dart';

class DriverTripTraficBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriverTripTraficController());
  }
}