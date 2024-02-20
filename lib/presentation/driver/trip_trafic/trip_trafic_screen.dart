import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/app_export.dart';
import '../../../core/constants/constant.dart';
import '../../../core/utils/app_strings.dart';
import 'controller/trip_controller.dart';

class DriverTripTraficScreen extends GetWidget<DriverTripTraficController> {

  Widget build(BuildContext context) {
    return  Scaffold(
      endDrawer: Drawer(
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
                          Text('Trip started at',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold) ),
                          SizedBox(height: 5.0,),
                          Text('09:00 AM')
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
                          Text('My Be arrived at',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold) ),
                          SizedBox(height: 5.0,),
                          Text('02:00 PM')
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
              child: ListView.builder(itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('${index+1}'),
                      ),
                      title: Text('test ${index+1}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('distance : ${(index+1)*50} m'),
                          Text('address : Rajshahi')
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () {

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
              },itemCount: 3,),
            ),
          ],
        ),
      ),
      body:Column(
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
                TextButton(onPressed: (){
                  controller.reTest();
                }, child: Text('Re-Test'))
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
                          startMapLocation.latitude,
                          startMapLocation.longitude,
                        ),
                        radius: 2,
                      )
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(startMapLocation.latitude, startMapLocation.longitude),
                      zoom: 19,
                    ),
                    onMapCreated: (_controller) {
                      controller.mapController = _controller;
                    },
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId("route"),
                        points: controller.polylineCoordinates,
                        color: theme.primaryColor,
                        width: 6,
                      ),
                    },
                    onTap: (argument) {
                      print(argument);
                    },
                    markers: {
                      Marker(
                        markerId: MarkerId('Start Location'),
                        position: LatLng(controller.startLocation.value.latitude ?? startMapLocation.latitude,
                            controller.startLocation.value.longitude ?? startMapLocation.longitude),
                        infoWindow: InfoWindow(title: 'Start Location'),
                      ),
                      Marker(
                        markerId: MarkerId('Location1'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                        position: LatLng(controller.endLocation.value.latitude ?? startMapLocation.latitude,
                            controller.endLocation.value.longitude ?? startMapLocation.longitude),
                        infoWindow: InfoWindow(title: 'End Location'),
                      ),
                      Marker(
                        markerId: MarkerId('Location2'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                        position: LatLng(24.777204071188088, 46.74148555845022),
                        infoWindow: InfoWindow(title: 'End Location'),
                      ),
                      Marker(
                        markerId: MarkerId('Location3'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
                        position: LatLng(24.77586525979226, 46.74012769013643),
                        infoWindow: InfoWindow(title: 'End Location'),
                      ),
                    },
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

}
