import 'package:flutter/material.dart';
import 'package:linkbus/data/remote_date_source/remote_data_source.dart';
import '../../../../../core/app_export.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../../core/utils/state_renderer/state_renderer_impl.dart';
class DriverLoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;
  RxBool obscurePassword = true.obs;
  DriverRemoteDataSourceImpl driverRemoteDataSource = Get.find<DriverRemoteDataSourceImpl>();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login()  async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await driverRemoteDataSource.signIn(usernameController.text, passwordController.text)).fold(
            (l) {
          state.value = ErrorState(
              StateRendererType.popupErrorState,
              l.message
          ) ;
        }, (r){
          if(r){
            Get.offAllNamed(AppRoutes.driverMainScreen);
          }else {
            state.value = ErrorState(
                StateRendererType.popupErrorState,
                AppStrings.noDriver
            );
          }
          state.value = ContentState();
        });
  }
}