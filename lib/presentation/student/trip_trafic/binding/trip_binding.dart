import 'package:linkbus/presentation/student/trip_trafic/controller/trip_controller.dart';

import '../../../../core/app_export.dart';

class TripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripTraficController());
  }
}