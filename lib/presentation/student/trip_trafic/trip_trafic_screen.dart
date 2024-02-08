import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linkbus/presentation/student/trip_trafic/controller/trip_controller.dart';

import '../../../core/app_export.dart';
import '../../../core/constants/constant.dart';
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
            subtitle:Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.timer,color: theme.primaryColor,),
                SizedBox(width: 10.0,),
                Obx(()=> Expanded(child: Text(controller.timer.value))),
              ],
            ),
            trailing: TextButton(onPressed: (){
              controller.reTest();
            }, child: Text('Re-Test')),
          ),
          Expanded(
            child: Container(
                height: 200,
                child: GoogleMap(
                  mapType: MapType.terrain,
                  myLocationEnabled:true ,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      controller.currentLocation_.value.latitude ?? startMapLocation.latitude,
                      controller.currentLocation_.value.longitude ?? startMapLocation.longitude,
                    ),
                    zoom: 16,
                  ),
                  onMapCreated: (_controller) {
                    controller.mapController = _controller ;                    // Do other initialization as needed
                  },
                ),
              )
          ),
        ],
      ),
    );
  }

}
