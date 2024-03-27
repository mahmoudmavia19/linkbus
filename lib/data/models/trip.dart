import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trip {
  String? uid ;
  String? driver ;
  String? title ;
  bool started = false ;
  bool selected = false ;
  Timestamp? dateTime ;
  GeoPoint? startLocation;
  GeoPoint? endLocation;
  List<String> passengers = [];
  Trip({required this.uid, required this.title, this.started = false, required this.dateTime,});

  Trip.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    driver = json['driver'];
    uid = json['uid'];
    started = json['started'];
    dateTime = json['dateTime'];
    startLocation = json['startLocation'];
    endLocation = json['endLocation'];
    passengers = json['passengers'].cast<String>();
  }

  toJson() {
    return {
      'uid': uid,
      'dateTime': dateTime,
      'title': title,
      'started': started,
      'passengers': passengers,
      'startLocation': startLocation,
      'endLocation': endLocation,
      'driver': driver
    };
  }
}