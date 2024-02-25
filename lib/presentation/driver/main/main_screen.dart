import 'package:flutter/material.dart';
import 'package:linkbus/core/app_export.dart';
import '../../../core/utils/app_strings.dart';
import 'controller/main_controller.dart';
class DriverMainScreen extends GetWidget<DriverMainController>{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Hi name'),
        leading:IconButton(onPressed: () {
          Get.toNamed(AppRoutes.driverHelpScreen);
        }, icon: Image.asset(ImageConstant.service),),
        actions: [
          Image.asset(ImageConstant.imgLogo,width:100,fit: BoxFit.cover,),
        ],
      ),
      body:PageView.builder(
        controller:  controller.pageController,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder:(context, index) => controller.screens[index],
        onPageChanged: (value) {
          controller.currentIndex.value = value;
        },
      ) ,
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (value) {
            controller.pageController.jumpToPage(value);
          },
     items:[
            BottomNavigationBarItem(icon: Icon(Icons.home),label: AppStrings.home),
            BottomNavigationBarItem(icon: Icon(Icons.location_history),label: AppStrings.location),
            BottomNavigationBarItem(icon: Icon(Icons.map),label: AppStrings.map),
          ]),
      ),

    );
  }
}
