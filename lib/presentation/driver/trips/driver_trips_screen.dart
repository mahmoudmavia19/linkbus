 import 'package:flutter/material.dart';
 import 'package:intl/intl.dart';
 import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:linkbus/data/models/trip.dart';
import 'package:linkbus/presentation/driver/trips/controller/driver_trips_controller.dart';

import '../../../core/utils/app_strings.dart';

class DriverTripsScreen extends GetWidget<DriverTripsController> {

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 60.0,bottom: 20.0),
            child: Text(AppStrings.scheduleUpcomingTrips,style: theme.textTheme.titleLarge,),
          ),
           Obx(
           ()=> controller.state.value.getScreenWidget(_tripsBody(),(){})
           ),
          SizedBox(height: 50.0,),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 150,
              child: TextButton(onPressed: (){
                Get.offAndToNamed(AppRoutes.chooseUserTypeScreen);
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
          )
        ]
    );
  }
_tripsBody()=> Expanded(
  child: ListView.builder(itemBuilder: (context, index) => _tripCard(controller.trips[index]),
      itemCount: controller.trips.length),
);
  _tripCard(Trip trip)=>SizedBox(
    width: double.infinity,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text('${AppStrings.trip} ${DateFormat.jm().format(trip.dateTime!.toDate())} to ${trip.title}',style: theme.textTheme.bodyLarge,)),
            SizedBox(
              height: 35,
              width: 100,
              child: trip.dateTime!.toDate().hour==DateTime.now().hour? ElevatedButton(onPressed: () {
                controller.startTripVoid(trip);
              },
                  child: Text(controller.startTrip.value?AppStrings.end : AppStrings.start),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:controller.startTrip.value?Colors.red:  Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                  )
              ):ElevatedButton(onPressed: () {
                controller.startTripVoid(trip);
              },
                  child: Text(AppStrings.start),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                  )
              ),
              ),

          ],
        ),
      ),
    ),
  );
}
