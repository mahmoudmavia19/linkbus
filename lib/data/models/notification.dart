import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String? uid ;
  DateTime? dateTime ;
  String? message ;
  String? title ;
  Notification({required this.uid, required this.dateTime, required this.message});
  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    uid = json['uid'];
    message = json['message'];
    // get date time from date stamp
    dateTime = DateTime.fromMillisecondsSinceEpoch((json['dateTime'] as Timestamp).millisecondsSinceEpoch);
  }
  toJson() {
    return {
      'uid': uid,
      'dateTime': dateTime?.toIso8601String(),
      'message': message,
      'title': title
    };
  }

}