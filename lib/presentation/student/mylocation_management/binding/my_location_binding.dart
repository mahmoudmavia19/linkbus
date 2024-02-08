import '../../../../core/app_export.dart';
import '../controller/my_location_controller.dart';

class MyLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyLocationController());
  }
}