import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:linkbus/data/models/notification.dart';
import 'package:linkbus/data/remote_date_source/passenger_remote_data_source.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';

class NotificationController extends GetxController {
  Rx<FlowState> state = Rx(ContentState());
  RxList<Notification> notifications = <Notification>[].obs;
  PassengerRemoteDataSource passengerRemoteDataSource =
      PassengerRemoteDataSourceImpl(Get.find(), Get.find());
  void getNotifications() async {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    await passengerRemoteDataSource.getNotifications().listen(
          (either) {
        either.fold(
              (failure) {
            state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
          },
              (notifications) {
            this.notifications.value = notifications;
            state.value = ContentState();
          },
        );
      },
      onError: (error) {
        state.value = ErrorState(StateRendererType.popupErrorState, 'An error occurred');
      },
      cancelOnError: true, // Cancel the subscription on error
    );
  }

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }


}