import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/presentation/student/home_screen/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}