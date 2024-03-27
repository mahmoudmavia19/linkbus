import 'package:google_maps_flutter/google_maps_flutter.dart';

class Driver {
  String? uid;
  String? name ;
  String? email ;
  String? address ;
  LatLng? location ;
  LatLng ? currentLocation ;
  Driver({required this.uid, required this.email, required this.location ,this.address,this.name,this.currentLocation});

  Driver.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    location = LatLng(json['location']['latitude'], json['location']['longitude']);
    currentLocation = LatLng(json['currentLocation']['latitude'], json['currentLocation']['longitude']);;
    address = json['address'];

  }
  toJson() {
    return {
      'uid': uid,
      'email': email,
      'location':{
        'latitude': location!.latitude,
        'longitude': location!.longitude
      },
      'currentLocation': currentLocation,
      'address': address,
      'name': name
    };
  }

}