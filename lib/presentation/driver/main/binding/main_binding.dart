import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/presentation/driver/main/controller/main_controller.dart';

class DriverMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriverMainController());
  }
}