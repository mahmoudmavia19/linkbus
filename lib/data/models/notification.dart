import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String? uid;
  DateTime? dateTime;
  String? message;
  String? title;

  Notification({this.uid, required this.dateTime, required this.message});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    uid = json['uid'];
    message = json['message'];
    // Parse string timestamp to DateTime
    if(json['dateTime'] is String){
      dateTime = DateTime.tryParse(json['dateTime']);
    }
    if(json['dateTime'] is Timestamp){
      dateTime = (json['dateTime'] as Timestamp).toDate();
    }

  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'dateTime': dateTime?.toIso8601String(),
      'message': message,
      'title': title,
    };
  }
}
