import 'package:flutter/material.dart';
import 'package:linkbus/core/utils/app_strings.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer.dart';

import '../../../../../core/app_export.dart';
import '../../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../../../../../data/remote_date_source/passenger_remote_data_source.dart';
class StudentLoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;
  RxBool obscurePassword = true.obs;

  PassengerRemoteDataSource passengerRemoteDataSource = Get.find<PassengerRemoteDataSourceImpl>();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login()  async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await passengerRemoteDataSource.signIn(usernameController.text, passwordController.text)).fold(
            (l) {
              state.value = ErrorState(
                 StateRendererType.popupErrorState,
                l.message
              ) ;
            },
            (r){
              if(r){
                Get.offAllNamed(AppRoutes.studentMainScreen);
              }else {
                state.value = ErrorState(
                  StateRendererType.popupErrorState,
                  AppStrings.noPassenger
                );
              }
              state.value = ContentState();
            });
  }

}