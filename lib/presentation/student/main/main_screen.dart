import 'package:flutter/material.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/presentation/student/home_screen/controller/home_controller.dart';
import 'package:linkbus/presentation/student/main/controller/main_controller.dart';

import '../../../core/utils/app_strings.dart';

class MainScreen extends GetWidget<MainController>{
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Hi ${homeController.passenger?.name??''}'),
        leading:IconButton(onPressed: () {
          Get.toNamed(AppRoutes.studentHelpScreen);
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
          BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined),label: AppStrings.location),
          BottomNavigationBarItem(icon: Icon(Icons.notifications),label: AppStrings.notification),
          BottomNavigationBarItem(icon: Icon(Icons.map),label: AppStrings.map),
        ]),
      ),

    );
  }
}
