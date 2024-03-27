import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linkbus/core/constants/constant.dart';
import 'package:linkbus/core/utils/app_strings.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer_impl.dart';

import '../../../core/app_export.dart';
import 'controller/my_location_controller.dart';

class DriverLocationManagementScreen extends GetWidget<DriverMyLocationController>{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Column(
        children: [
          ListTile(
             title: Text('My House',style: TextStyle(
               fontWeight: FontWeight.bold
             ),),
             trailing: TextButton(onPressed: () {
               controller.saveMyLocation();
             }, style: TextButton.styleFrom(
                   backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white
                 ),
                 child: Text(AppStrings.save)),
             subtitle:Row(
               mainAxisSize: MainAxisSize.min,
               children: [
                 Icon(Icons.location_on,color: theme.primaryColor,),
                 SizedBox(width: 10.0,),
                 Obx(()=> Expanded(child: Text(controller.address.value))),
               ],
             ),
          ),
          Expanded(
            child: Obx(() {
              return controller.state.value.getScreenWidget(_body(), (){});
            }),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(onPressed: () {
          controller.address.value = '';
        },child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_disabled),
            SizedBox(width: 10.0,) ,
            Text('Remove Location')
          ],
        ),),
      ),

    );
  }

  _body()=>Container(
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
      onTap: (argument) {
        print(argument);
        controller.chooseLocation(argument);
      },
      markers: {
        Marker(
          markerId: MarkerId('currentLocation'),
          position: LatLng(
            controller.currentLocation_.value.latitude ??  startMapLocation.latitude,
            controller.currentLocation_.value.longitude ??  startMapLocation.longitude,
          ),
          infoWindow: InfoWindow(title: 'Current Location'),
        ),
      },
    ),
  ) ;
}
