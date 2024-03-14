import 'package:flutter/material.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer_impl.dart';
import '../../../../core/app_export.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import 'controller/driver_controller.dart';

class DriverLoginPage extends GetWidget<DriverLoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.driver),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body:controller.state.value.getScreenWidget( LoginScreenUI(loginController: controller), (){

        }),
      ),
    );
  }
}

class LoginScreenUI extends StatelessWidget {
  final DriverLoginController loginController;

  const LoginScreenUI({Key? key, required this.loginController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(ImageConstant.imgLogo),
           TextFieldWidget(
            labelText: AppStrings.usernameOrEmail,
            controller: loginController.usernameController,
          ),
          SizedBox(height: 20),
          Obx(()=>TextFieldWidget(
              labelText: AppStrings.password,
              obscureText: loginController.obscurePassword.value,
              controller: loginController.passwordController,
              suffixIcon: IconButton(
                icon: Icon(
                  loginController.obscurePassword.value ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: loginController.togglePasswordVisibility,
              ) ,
            ),
          ),
          SizedBox(height: 20),
          ButtonWidget(onPressed: loginController.login, text:AppStrings.login,),
         ],
      ),
    );
  }
}

