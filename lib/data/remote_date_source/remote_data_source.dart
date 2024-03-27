import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/data/apiClient/api_driver_client.dart';
import 'package:linkbus/data/models/driver.dart';
import 'package:linkbus/data/models/notification.dart';
import 'package:linkbus/data/models/passenger.dart';
import 'package:linkbus/data/models/trip.dart';

import '../../core/errors/error_handler.dart';
import '../../core/errors/failure.dart';

abstract class DriverRemoteDataSource {
  Future<Either<Failure,bool>> signIn(String email, String password);
  Future<Either<Failure,List<Trip>>> getTrips();
  Future<Either<Failure,void>> updateTrip(Trip trip);
  Future<Either<Failure,void>> saveMyLocation(Driver driver);
  Future<Either<Failure,void>> shareMyLocation(LatLng location);
  Future<Either<Failure,Driver>> getDriver();
  Future<Either<Failure,List<Passenger>>> getPassengerForTrip(tripId);
  Future<Either<Failure,void>> sendNotification(Trip trip,Notification notification);
}
class DriverRemoteDataSourceImpl implements DriverRemoteDataSource {

  ApiDriverClient apiClient  ;
  NetworkInfo networkInfo ;


  DriverRemoteDataSourceImpl(this.apiClient, this.networkInfo);

  @override
  Future<Either<Failure,bool>> signIn(String email, String password) async{
   if(await networkInfo.isConnected()){
     try {
       var result = await apiClient.signIn(email, password);
       return Right(result);
     }catch(e){
       return Left(ErrorHandler.handle(e).failure);
     }
   } else {
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
   }
  }

  @override
  Future<Either<Failure, List<Trip>>> getTrips()async {
    if(await networkInfo.isConnected()){
      try{
        var result = await apiClient.getTrips();
        return Right(result);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveMyLocation(Driver driver)async {
    if(await networkInfo.isConnected()){
      try{
        var result = await apiClient.saveMyLocation(driver);
        return Right(result);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> shareMyLocation(LatLng location) async{
        if(await networkInfo.isConnected()){
          try{
            var result = await apiClient.shareMyLocation(location);
            return Right(result);
          } catch(e){
            return Left(ErrorHandler.handle(e).failure);
          }
        } else {
          return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
        }
  }

  @override
  Future<Either<Failure, Driver>> getDriver() async{
     if(await networkInfo.isConnected()){
       try{
         var result = await apiClient.getDriver();
         return Right(result);
        } catch(e){
          return Left(ErrorHandler.handle(e).failure);
        }
     }  else {
       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
     }
  }

  @override
  Future<Either<Failure, List<Passenger>>> getPassengerForTrip(tripId) async{
    if(await networkInfo.isConnected()){
      try{
        var result = await apiClient.getPassengersForTrip(tripId);
        return Right(result);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    }  else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTrip(Trip trip)async {
    if(await networkInfo.isConnected()){
      try{
        var result = await apiClient.updateTrip(trip);
        return Right(result);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendNotification(Trip trip, Notification notification) async{
    if(await networkInfo.isConnected()){
      try{
        var result = await apiClient.sendNotification(trip,notification);
        return Right(result);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}