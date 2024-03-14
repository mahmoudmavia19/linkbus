import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/data/apiClient/api_client.dart';
import 'package:linkbus/data/apiClient/api_driver_client.dart';
import 'package:linkbus/data/remote_date_source/remote_data_source.dart';

import '../../data/remote_date_source/passenger_remote_data_source.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Get.put(ApiClient(auth, firestore));
    Get.put(ApiDriverClient(auth, firestore));
    Get.put(NetworkInfo(connectivity));
    Get.put(DriverRemoteDataSourceImpl(Get.find(), Get.find()));
    Get.put(PassengerRemoteDataSourceImpl(Get.find(), Get.find()));
  }
}
