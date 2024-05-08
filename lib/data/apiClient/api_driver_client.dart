import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/data/models/notification.dart';
import 'package:linkbus/data/models/passenger.dart';

import '../../core/constants/constant.dart';
import '../models/driver.dart';
import '../models/trip.dart';

class ApiDriverClient extends GetConnect {

  FirebaseAuth auth;
  FirebaseFirestore firestore;


  ApiDriverClient(this.auth, this.firestore);

  Future<bool> signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    if ((await firestore.collection('drivers').doc(auth.currentUser!.uid).get())
        .exists) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<void> saveMyLocation(Driver driver) async {
    await firestore.collection('drivers').doc(auth.currentUser!.uid).set(
        driver.toJson());
  }

  Future<void> shareMyLocation(LatLng latLng) async {
    await firestore.collection('drivers').doc(auth.currentUser!.uid).update(
        {'currentLocation': {
          'latitude': latLng.latitude,
          'longitude': latLng.longitude
        }});
  }

  Future<List<Passenger>> getPassengersForTrip(String tripId) async {
    var result = await firestore.collection('trips').doc(tripId).get();
    var trip = Trip.fromJson(result.data()!);
    List<Passenger> passengers = [];
    for (var passenger in trip.passengers) {
      var result = await firestore.collection('passengers')
          .doc(passenger)
          .get();
      passengers.add(Passenger.fromJson(result.data()!));
    }
    return passengers;
  }

  Future<List<Trip>> getTrips() async {
    var result = await firestore.collection('trips').get();
    return result.docs.map((e) => Trip.fromJson(e.data())).toList();
  }

  // test send trips

  Future<void> updateTrip(Trip trip) async {
    await firestore.collection('trips').doc(trip.uid).update(trip.toJson());
  }

  Future<Driver> getDriver() async {
    var result = await firestore.collection('drivers').doc(
        auth.currentUser!.uid).get();
    return Driver.fromJson(result.data()!);
  }

  sendNotification(Trip trip,Notification notification) async {
    for (var passenger in trip.passengers) {
      var result = await firestore.collection('passengers')
          .doc(passenger).collection('notifications').add(notification.toJson());
    }
    sendNotificationMFC(trip.uid!,notification);
  }
}
