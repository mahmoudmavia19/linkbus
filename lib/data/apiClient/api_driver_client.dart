import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:linkbus/core/app_export.dart';

class ApiDriverClient extends GetConnect {

  FirebaseAuth auth;
  FirebaseFirestore firestore;


  ApiDriverClient(this.auth, this.firestore);

  Future<bool> signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    if((await firestore.collection('drivers').doc(auth.currentUser!.uid).get()).exists){
      return true;
    }
    else{
      return false;
    }

  }
}

