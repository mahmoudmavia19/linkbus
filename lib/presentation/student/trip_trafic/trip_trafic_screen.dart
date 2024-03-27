import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linkbus/presentation/student/trip_trafic/controller/trip_controller.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/app_strings.dart';

class TripTraficScreen extends GetWidget<TripTraficController> {

  Widget build(BuildContext context) {
    return  Scaffold(
      body:Column(
        children: [
          ListTile(
            title: Text(AppStrings.remaining,style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
            subtitle:Column(
              mainAxisSize: MainAxisSize.min,
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
              ],
            ),
            /*trailing: TextButton(onPressed: (){
              controller.reTest();
            }, child: Text('Re-Test')),*/
          ),
          Expanded(
            child: Container(
                height: 200,
                child: Obx(
                      () =>controller.trip.value==null && controller.trip.value?.started!=true?
                      Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text('No Trip Found',style: TextStyle(fontSize: 20.0),),
                          ),
                        ) ,
                      )
                          :  GoogleMap(
                    mapType: MapType.terrain,
                    myLocationEnabled: true,
                    circles: {
                      Circle(
                        circleId: const CircleId("start"),
                        center: LatLng(
                          controller.trip.value!.startLocation!.latitude,
                          controller.trip.value!.startLocation!.longitude,
                        ),
                        radius: 2,
                      )
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        controller.trip.value!.startLocation!.latitude,
                        controller.trip.value!.startLocation!.longitude,
                      ),
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
                        position: LatLng(controller.startLocation.value!.latitude!,
                            controller.startLocation.value!.longitude!),
                        infoWindow: InfoWindow(title: 'Start Location'),
                      ),
                      Marker(
                        markerId: MarkerId('End Location'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                        position: LatLng(controller.endLocation.value!.latitude!,
                            controller.endLocation.value!.longitude!),
                        infoWindow: InfoWindow(title: 'End Location'),
                      ),
                      if(controller.driver.value != null)
                      Marker(markerId: MarkerId(controller.driver.value!.uid!),
                        position: controller.driver.value!.currentLocation!,
                        infoWindow: InfoWindow(title: controller.driver.value!.name),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
                      )
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
