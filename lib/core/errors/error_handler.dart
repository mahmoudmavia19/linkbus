 /// todo handle all firebase Error message to arabic message

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is FirebaseException) {
      // firebase error so its an error from response of the API or from firebase itself
      print('--------------------------------${error.code} ------------------------- ${error.message}') ;
      failure = error.getArabicMessage();
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }

}

 enum DataSource {
   SUCCESS,
   CANCEL,
   CACHE_ERROR,
   NO_INTERNET_CONNECTION,
   DEFAULT,
   UNKNOWN,
   WRONG_PASSWORD,
   INVALID_EMAIL,
   TOO_MANY_REQUESTS,
   USER_NOT_FOUND,
   USER_DISABLED,
   EMAIL_ALREADY_IN_USE, // New error code
   OPERATION_NOT_ALLOWED, // New error code
   WEAK_PASSWORD,
   InvalidCredential
 }

 extension DataSourceString on DataSource {
   String getString() {
     switch (this) {
       case DataSource.SUCCESS:
         return 'success';
       case DataSource.CANCEL:
         return 'cancel';
       case DataSource.CACHE_ERROR:
         return 'cache-error';
       case DataSource.NO_INTERNET_CONNECTION:
         return 'no-internet-connection';
       case DataSource.DEFAULT:
         return 'default';
       case DataSource.UNKNOWN:
         return 'unknown';
       case DataSource.WRONG_PASSWORD:
         return 'wrong-password';
       case DataSource.INVALID_EMAIL:
         return 'invalid-email';
       case DataSource.TOO_MANY_REQUESTS:
         return 'too-many-requests';
       case DataSource.USER_NOT_FOUND:
         return 'user-not-found';
       case DataSource.USER_DISABLED:
         return 'user-disabled';
       case DataSource.EMAIL_ALREADY_IN_USE:
         return 'email-already-in-use';
       case DataSource.OPERATION_NOT_ALLOWED:
         return 'operation-not-allowed';
       case DataSource.WEAK_PASSWORD:
         return 'weak-password';
       case DataSource.InvalidCredential:
         return 'invalid-credential';
     }
   }
 }


 extension FirebaseArabicErrorMessage on FirebaseException {
   Failure getArabicMessage() {
     switch (code) {
       case 'unknown':
         return DataSource.UNKNOWN.getFailure();
       case 'wrong-password':
         return DataSource.WRONG_PASSWORD.getFailure();
       case 'invalid-email':
         return DataSource.INVALID_EMAIL.getFailure();
       case 'too-many-requests':
         return DataSource.TOO_MANY_REQUESTS.getFailure();
       case 'user-not-found':
         return DataSource.USER_NOT_FOUND.getFailure();
       case 'user-disabled':
         return DataSource.USER_DISABLED.getFailure();
       case 'email-already-in-use':
         return DataSource.EMAIL_ALREADY_IN_USE.getFailure();
       case 'operation-not-allowed':
         return DataSource.OPERATION_NOT_ALLOWED.getFailure();
       case 'weak-password':
         return DataSource.WEAK_PASSWORD.getFailure();
       case 'invalid-credential':
         return DataSource.InvalidCredential.getFailure();
       default:
         return DataSource.DEFAULT.getFailure();
     }
   }
 }


 extension DataSourceExtension on DataSource {
   Failure getFailure() {
     switch (this) {
       case DataSource.SUCCESS:
         return Failure(ResponseCode.SUCCESS.toString(), ResponseMessage.SUCCESS);
       case DataSource.CANCEL:
         return Failure(ResponseCode.CANCEL.toString(), ResponseMessage.CANCEL);
       case DataSource.CACHE_ERROR:
         return Failure(ResponseCode.CACHE_ERROR.toString(), ResponseMessage.CACHE_ERROR);
       case DataSource.NO_INTERNET_CONNECTION:
         return Failure(ResponseCode.NO_INTERNET_CONNECTION.toString(), ResponseMessage.NO_INTERNET_CONNECTION);
       case DataSource.DEFAULT:
         return Failure(ResponseCode.DEFAULT.toString(), ResponseMessage.DEFAULT);
       case DataSource.UNKNOWN:
         return Failure(ResponseCode.UNKNOWN.toString(), ResponseMessage.UNKNOWN);
       case DataSource.WRONG_PASSWORD:
         return Failure(ResponseCode.WRONG_PASSWORD.toString(), ResponseMessage.WRONG_PASSWORD);
       case DataSource.INVALID_EMAIL:
         return Failure(ResponseCode.INVALID_EMAIL.toString(), ResponseMessage.INVALID_EMAIL);
       case DataSource.TOO_MANY_REQUESTS:
         return Failure(ResponseCode.TOO_MANY_REQUESTS.toString(), ResponseMessage.TOO_MANY_REQUESTS);
       case DataSource.USER_NOT_FOUND:
         return Failure(ResponseCode.USER_NOT_FOUND.toString(), ResponseMessage.USER_NOT_FOUND);
       case DataSource.USER_DISABLED:
         return Failure(ResponseCode.USER_DISABLED.toString(), ResponseMessage.USER_DISABLED);
       case DataSource.EMAIL_ALREADY_IN_USE:
         return Failure(ResponseCode.EMAIL_ALREADY_IN_USE.toString(), ResponseMessage.EMAIL_ALREADY_IN_USE);
       case DataSource.OPERATION_NOT_ALLOWED:
         return Failure(ResponseCode.OPERATION_NOT_ALLOWED.toString(), ResponseMessage.OPERATION_NOT_ALLOWED);
       case DataSource.WEAK_PASSWORD:
         return Failure(ResponseCode.WEAK_PASSWORD.toString(), ResponseMessage.WEAK_PASSWORD);
       case DataSource.InvalidCredential:
         return Failure(ResponseCode.InvalidCredential.toString(), ResponseMessage.InvalidCredential);
     }
   }
 }
 class ResponseCode {
   static const int SUCCESS = 200;
   static const int CANCEL = -2;
   static const int CACHE_ERROR = -5;
   static const int NO_INTERNET_CONNECTION = -6;
   static const int DEFAULT = -7;
   static const int UNKNOWN = 100;
   static const int WRONG_PASSWORD = 101;
   static const int INVALID_EMAIL = 102;
   static const int TOO_MANY_REQUESTS = 103;
   static const int USER_NOT_FOUND = 104;
   static const int USER_DISABLED = 105;
   static const int EMAIL_ALREADY_IN_USE = 106;
   static const int OPERATION_NOT_ALLOWED = 107;
   static const int WEAK_PASSWORD = 108;
   static const int InvalidCredential = 109;
 }

 class ResponseMessage {
   static const String SUCCESS = "Login successful";
   static const String CANCEL = "Request canceled, please try again later";
   static const String CACHE_ERROR = "Cache error, please try again later";
   static const String NO_INTERNET_CONNECTION = "Please check your internet connection";
   static const String DEFAULT = "An error occurred, please try again later";
   static const String UNKNOWN = "Content cannot be left empty";
   static const String WRONG_PASSWORD = "Invalid password or user has no password";
   static const String INVALID_EMAIL = "Invalid email address";
   static const String TOO_MANY_REQUESTS = "We have blocked all requests from this device due to unusual activity. Please try again later";
   static const String USER_NOT_FOUND = "No user record corresponding to this identifier. User may have been deleted";
   static const String USER_DISABLED = "User account has been disabled";
   static const String EMAIL_ALREADY_IN_USE = "Email address is already in use by another account";
   static const String OPERATION_NOT_ALLOWED = "Email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab";
   static const String WEAK_PASSWORD = "Password must be at least 8 characters long";
   static const String InvalidCredential = "Invalid, incorrect, or expired authentication credentials were provided.";
 }

 class ApiInternalStatus{
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}