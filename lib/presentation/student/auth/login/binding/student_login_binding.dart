import '../../../../../core/app_export.dart';
import '../controller/auth_controller.dart';

class StudentLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudentLoginController());
  }
}