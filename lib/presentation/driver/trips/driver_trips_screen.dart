import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/presentation/driver/trips/controller/driver_trips_controller.dart';

import '../../../core/utils/app_strings.dart';
import '../../../theme/theme_helper.dart';

class DriverTripsScreen extends GetWidget<DriverTripsController> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 60.0,bottom: 20.0),
              child: Text(AppStrings.scheduleUpcomingTrips,style: theme.textTheme.titleLarge,),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text('${AppStrings.trip} 6:00 AM to PNU',style: theme.textTheme.bodyLarge,)),
                      SizedBox(
                        height: 35,
                        width: 100,
                        child: Obx(()=>ElevatedButton(onPressed: () {
                          controller.toggleStartTrip();
                        },
                              child: Text(controller.startTrip.value?AppStrings.end : AppStrings.start),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:controller.startTrip.value?Colors.red:  Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text('${AppStrings.trip} 9:00 AM to PNU',style: theme.textTheme.bodyLarge,)),
                      SizedBox(
                        height: 35,
                        width: 100,
                        child: ElevatedButton(onPressed: () {
                        },
                            child: Text(AppStrings.start),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
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
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text('${AppStrings.trip} 12:00 PM to Jasmine neighborhood',style: theme.textTheme.bodyLarge,)),
                      SizedBox(
                        height: 35,
                        width: 100,
                        child: ElevatedButton(onPressed: () {
                        },
                            child: Text(AppStrings.start),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                foregroundColor: Colors.black,
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
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text('${AppStrings.trip} 3:00 PM to Jasmine neighborhood',style: theme.textTheme.bodyLarge,)),
                      SizedBox(
                        height: 35,
                        width: 100,
                        child: ElevatedButton(onPressed: () {
                        },
                            child: Text(AppStrings.start),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                foregroundColor: Colors.black,
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
      ),
    );
  }
}
