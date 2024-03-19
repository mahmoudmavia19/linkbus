import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/presentation/student/notification/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}