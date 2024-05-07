import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/app_strings.dart';
import '../trips/controller/driver_trips_controller.dart';
import 'controller/trip_controller.dart';

class DriverTripTraficScreen extends GetWidget<DriverTripTraficController> {
  DriverTripsController driverTripsController = Get.find();
   Widget build(BuildContext context) {
    return  Scaffold(
      endDrawer:driverTripsController.trip.value==null ?Container() :Drawer(
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            Container(
              height:70,
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                         border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Text('Trip started at',style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold) ),
                          SizedBox(height: 5.0,),
                          Text('${DateFormat.jm().format(driverTripsController.trip.value!.dateTime!.toDate())}')
                        ],
                      ),
                    ),),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Text('Trip my be ended at',style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold) ),
                          SizedBox(height: 5.0,),
                          Text('${DateFormat.jm().format(driverTripsController.trip.value!.dateTime!.toDate().add(Duration(hours: 2)))}')
                        ],
                      ),
                    ),
                  )
                ]
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.people,color: theme.primaryColor,size: 30.0,),
                SizedBox(width: 10.0,),
                Text('Passengers',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
              ],
            ),
            Divider(),
            Expanded(
              child: Obx(
                  ()=>ListView.builder(itemBuilder: (context, index) {
                  var passenger = controller.passengers[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('${index+1}'),
                        ),
                        title: Text('${passenger.name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('address : ${passenger.address}')
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: () {
                            Get.back();
                            controller.mapController.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  passenger.location!.latitude,
                                  passenger.location!.longitude,
                                ),
                                zoom: 19.0,
                              )
                            ));
                          }, icon: Row(
                            children: [
                              Icon(Icons.location_history,color: theme.primaryColor,size: 35.0,),
                              Text('Location',style: TextStyle(color: theme.primaryColor),)
                            ],
                          ),),
                        ],
                      ),
                      Divider()
                    ],
                  );
                },itemCount: controller.passengers.length,),
              ),
            ),
          ],
        ),
      ),
      body: Obx(()=>driverTripsController.trip.value==null? Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('No Trip Found',style: TextStyle(fontSize: 20.0),),
          ),
        ) ,
      ) :  Column(
          children: [
            ListTile(
              title: Text(AppStrings.remaining,style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
              subtitle:Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.timer,color: theme.primaryColor,),
                      SizedBox(width: 10.0,),
                      Obx(()=> Expanded(child: Text(controller.timer.value))),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.social_distance,color: theme.primaryColor,),
                      SizedBox(width: 10.0,),
                      Obx(()=> Expanded(child: Text('${controller.newDistance.value}m'))),
                    ],
                  ),
                 /* TextButton(onPressed: (){
                    controller.reTest();
                  }, child: Text('Re-Test'))*/
                ],
              ),
              trailing:Builder(
                builder: (context) {
                  return ElevatedButton(onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  }, child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Passengers',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),),
                  ));

                }
              ),),
            Expanded(
              child: Container(
                  height: 200,
                  child: Obx(
                        () => GoogleMap(
                      mapType: MapType.terrain,
                      myLocationEnabled: true,
                      circles: {
                        Circle(
                          circleId: const CircleId("start"),
                          center: LatLng(
                            driverTripsController.trip.value!.startLocation!.latitude,
                            driverTripsController.trip.value!.startLocation!.longitude,
                          ),
                          radius: 2,
                        )
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(driverTripsController.trip.value!.startLocation!.latitude, driverTripsController.trip.value!.startLocation!.longitude),
                        zoom: 19,
                      ),
                      onMapCreated: (_controller) {
                        controller.mapController = _controller;
                      },
                      polylines: /*{
                        Polyline(
                          polylineId: const PolylineId("route"),
                          points: controller.polylineCoordinates,
                          color: theme.primaryColor,
                          width: 6,
                        ),
                      }*/controller.polyLines.toSet(),
                      onTap: (argument) {
                        print(argument);
                      },
                      markers: {
                        for(var item in controller.passengers)
                          if(item.location!=null)
                        Marker(
                          markerId: MarkerId(item.uid ?? '0'),
                          position: LatLng(item.location!.latitude ,
                              item.location!.longitude),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
                          infoWindow: InfoWindow(title: item.name ?? ''),
                        ),
                        Marker(
                          markerId: MarkerId(driverTripsController.trip.value!.startLocation.toString()),
                          position: LatLng(driverTripsController.trip.value!.startLocation!.latitude ,
                              driverTripsController.trip.value!.startLocation!.longitude),
                          infoWindow: InfoWindow(title:'Start Location'),
                        ),
                        Marker(
                          markerId: MarkerId(driverTripsController.trip.value!.endLocation.toString()),
                          position: LatLng(driverTripsController.trip.value!.endLocation!.latitude ,
                              driverTripsController.trip.value!.endLocation!.longitude)
                          ,
                          infoWindow: InfoWindow(title:'End Location'),
                        ),
                      },
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Visibility(
        visible: driverTripsController.trip.value!=null,
        child: FloatingActionButton(onPressed: (){

          driverTripsController.updateTripIsStarted(false);
        },child: Text('End Trip'),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }

}
