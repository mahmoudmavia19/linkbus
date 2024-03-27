 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
  import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/data/models/driver.dart';
import 'package:linkbus/data/models/passenger.dart';

import '../models/notification.dart';
import '../models/trip.dart';

class ApiClient extends GetConnect {

  FirebaseAuth auth ;
  FirebaseFirestore firestore ;

  ApiClient(this.auth, this.firestore);

  Future<bool> signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    if((await firestore.collection('passengers').doc(auth.currentUser!.uid).get()).exists){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> saveMyLocation (Passenger passenger) async {
    await firestore.collection('passengers').doc(auth.currentUser!.uid).set(passenger.toJson());
  }

  Future<void> shareMyLocation (Passenger passenger) async {
    await firestore.collection('passengers').doc(auth.currentUser!.uid).set(passenger.toJson());
  }

  Stream<List<Notification>> getNotificationsStream() {
    return firestore
        .collection('passengers')
        .doc(auth.currentUser!.uid)
        .collection('notifications')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) => Notification.fromJson(doc.data()))
        .toList());
  }

  Stream<Driver> getDriverStream(driverId) {
    return firestore
        .collection('drivers')
        .doc(driverId)
        .snapshots()
        .map((doc) => Driver.fromJson(doc.data()!));
  }

  Future<Passenger> getPassenger() async {
    var result = await firestore.collection('passengers').doc(auth.currentUser!.uid).get();
    return Passenger.fromJson(result.data()!);
  }

  Future<List<Trip>> getTrips() async {
    var result = await firestore.collection('trips').get();
    return result.docs.map((e) => Trip.fromJson(e.data())).toList();
  }

  // test send trips

  Future<void> updateTrip(Trip trip) async{
    await firestore.collection('trips').doc(trip.uid).update(trip.toJson());
  }

Future<void> sendTrips() async {
    List<Trip> trips = [
      Trip(
        title: 'PNU',
        dateTime: Timestamp.now(),
        uid: '',
        started: false,
      ),
      Trip(
        title: 'PNU',
        dateTime: Timestamp.now(),
        uid: '',
        started: false,
      ),
    ];

    for (var trip in trips) {
      await firestore.collection('trips').add(trip.toJson());
    }
   }

}

