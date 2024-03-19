import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  String? uid ;
  String? title ;
  bool started = false ;
  bool selected = false ;
  Timestamp? dateTime ;
  List<String> passengers = [];

  Trip({required this.uid, required this.title, this.started = false, required this.dateTime,});

  Trip.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    uid = json['uid'];
    started = json['started'];
    dateTime = json['dateTime'];
    passengers = json['passengers'].cast<String>();
  }

  toJson() {
    return {
      'uid': uid,
      'dateTime': dateTime,
      'title': title,
      'started': started,
      'passengers': passengers
    };
  }
}