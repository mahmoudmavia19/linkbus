import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linkbus/data/models/notification.dart';

import '../../presentation/student/help_screen/model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

LatLng startMapLocation =  LatLng(24.774265, 46.738586);
class HelpData {
  static List<HelpQuestion> studentQuestions = [
    HelpQuestion(
      question: 'How do I log in to the system?',
      answer: 'To log in, go to the login page and enter your registered email and password.',
    ),
    HelpQuestion(
      question: 'How can I view my schedule and select trip times?',
      answer: 'You can access your schedule on the homepage. To select trip times, navigate to the trip scheduling section and follow the prompts.',
    ),
    HelpQuestion(
      question: 'What should I do if the driver hasn\'t started the trip yet?',
      answer: 'Please wait for a few minutes as the driver might be on the way to your location. If there\'s a significant delay, contact the transportation department for assistance.',
    ),
    HelpQuestion(
      question: 'How do I receive notifications about the driver\'s location?',
      answer: 'You will receive notifications when the driver starts the trip and when the driver approaches your location within 5 minutes.',
    ),
    HelpQuestion(
      question: 'What should I do if I encounter technical issues with the system?',
      answer: 'If you encounter technical issues, try refreshing the page or logging out and logging back in. If the issue persists, contact technical support for assistance.',
    ),
  ];

  static List<HelpQuestion> driverQuestions = [
    HelpQuestion(
      question: 'How do I log in to the system?',
      answer: 'To log in, visit the login page and enter your registered email and password.',
    ),
    HelpQuestion(
      question: 'How can I manage my locations and view student data?',
      answer: 'You can manage your locations in the location management section. Student data sorted by distance can be viewed in the corresponding section.',
    ),
    HelpQuestion(
      question: 'What should I do if a student doesn\'t show up at the designated location?',
      answer: 'Wait for a few minutes and try to contact the student. If the student doesn\'t show up and cannot be reached, you may proceed with the trip as scheduled.',
    ),
    HelpQuestion(
      question: 'How do I start the trip and notify students?',
      answer: 'You can start the trip from the trip management section. Students will receive notifications once the trip has started.',
    ),
    HelpQuestion(
      question: 'What should I do if I encounter technical issues with the system?',
      answer: 'If you encounter technical issues, try refreshing the page or logging out and logging back in. If the issue persists, contact technical support for assistance.',
    ),
  ];
}
List<Color> appColorsDigress = [
  Color(0xFFFFFFFF),
  Color(0xFFFFDA58),
  Color(0xFFECBD13),
  Color(0xFFE3AE06),
  ];


Future<void> sendNotificationMFC(String topic,Notification noti) async {
  // Your server key from Firebase Console
  String serverKey = 'AAAAwneGzTg:APA91bE7-1c-XyGt6u8qWXmp2FYyfCGv4N9gOhr8aPWy4CeUVMVF4RBfwhzoiZy0rwIHGq9fuZY5sjHSvujVwCHVB0mhHbAaJHmR0JUxKaIsIVWF0xqzlx56Y5zJ6qAEfmdMe4-gfVa6';

  // FCM endpoint
  String fcmUrl = 'https://fcm.googleapis.com/fcm/send';



  // Notification payload
  Map<String, dynamic> notification = {
    'to': '/topics/$topic',
    'notification': {
      'title': 'Linked Bus',
      'body': noti.message,
      'click_action': 'FLUTTER_NOTIFICATION_CLICK' // Optional: Handle click action in Flutter
    }
  };

  // Construct headers with authentication
  Map<String, String> headers = {
    'Authorization': 'key=$serverKey',
    'Content-Type': 'application/json'
  };

  // Send the notification
  try {
    http.Response response =
    await http.post(Uri.parse(fcmUrl), headers: headers, body: jsonEncode(notification));

    // Print the response
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  } catch (e) {
    print('Error sending notification: $e');
  }
}
