import '../../../../../core/app_export.dart';
import '../controller/driver_controller.dart';

class DriverLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriverLoginController());
  }
}