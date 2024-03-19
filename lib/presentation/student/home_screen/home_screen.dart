import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/core/utils/app_strings.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:linkbus/presentation/student/home_screen/controller/home_controller.dart';

class HomeScreen extends GetWidget<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
       children: [
         Expanded(
           child: Obx(()=> SingleChildScrollView(
               child: controller.state.value.getScreenWidget(_body(), (){}),
             ),
           ),
         ),
         Align(
           alignment: Alignment.center,
           child: SizedBox(
             width: 150,
             child: TextButton(onPressed: (){
                Get.offAllNamed(AppRoutes.chooseUserTypeScreen);
             } ,
                 style: TextButton.styleFrom(
                     backgroundColor: Colors.grey[200],
                     foregroundColor: Colors.red
                 ),
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Icon(Icons.logout),
                     SizedBox(width: 10.0,),
                     Text('Logout'),
                   ],
                 )),
           ),
         ),
         SizedBox(height: 10.0,)
       ])
    );
  }

  _body()=>SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(AppStrings.morningTripSchedule,style: theme.textTheme.titleLarge,),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.trips.length,
          itemBuilder: (context, index) {
            var trip = controller.trips[index];
            return SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text('${AppStrings.trip} ${DateFormat.jm().format(trip.dateTime!.toDate())} to PNU',style: theme.textTheme.bodyLarge,)),
                    SizedBox(
                      height: 30.0,
                      child: Switch(value: trip.selected,
                        onChanged: (value) {
                          trip.selected = value;
                          controller.updateTrip(trip);
                          print(value);
                        },),
                    )
                  ],
                ),
              ),
            ),
          );
          },),
      /*  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(AppStrings.eveningTripSchedule,style: theme.textTheme.titleLarge,),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) =>SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text('${AppStrings.trip} 6:00 AM to PNU',style: theme.textTheme.bodyLarge,)),
                    SizedBox(
                      height: 30.0,
                      child: Switch(value: true,
                        onChanged: (value) {},),
                    )
                  ],
                ),
              ),
            ),
          ),),*/
        SizedBox(height: 50.0,),
      ],
    ),
  );
}
