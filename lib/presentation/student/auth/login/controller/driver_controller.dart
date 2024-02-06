import 'package:flutter/material.dart';

import '../../../../../core/app_export.dart';
class StudentLoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
/*  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;*/
  RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async{

  }
}