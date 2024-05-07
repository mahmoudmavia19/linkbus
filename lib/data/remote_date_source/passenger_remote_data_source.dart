 import 'package:dartz/dartz.dart';
import 'package:linkbus/data/apiClient/api_client.dart';
import 'package:linkbus/data/apiClient/api_driver_client.dart';

import '../../core/errors/error_handler.dart';
import '../../core/errors/failure.dart';
import '../../core/network/network_info.dart';
import '../models/driver.dart';
import '../models/notification.dart';
import '../models/passenger.dart';
import '../models/trip.dart';

abstract class PassengerRemoteDataSource {
  Future<Either<Failure,bool>> signIn(String email, String password);
  Future<Either<Failure,void>> saveMyLocation(Passenger passenger);
  Future<Either<Failure,void>> shareMyLocation(Passenger passenger);
  Future<Either<Failure,void>> updateTrip(Trip trip);
  Stream<Either<Failure, List<Notification>>> getNotifications();
  Stream<Either<Failure, Driver>> getDriverStream(String driverId);
  Future<Either<Failure,Passenger>> getPassenger();
  Stream<Either<Failure,List<Trip>>> getTrips();

}
class PassengerRemoteDataSourceImpl implements PassengerRemoteDataSource {

  ApiClient apiClient ;
   NetworkInfo networkInfo ;

  PassengerRemoteDataSourceImpl(this.apiClient, this.networkInfo);

  @override
  Future<Either<Failure,bool>> signIn(String email, String password) async{
    if(await networkInfo.isConnected()){
      try{
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
  Stream<Either<Failure, List<Notification>>> getNotifications() async* {
    if (await networkInfo.isConnected()) {
      try {
        await for (var result in apiClient.getNotificationsStream()) {
          yield Right(result);
        }
      } catch (e) {
        yield Left(ErrorHandler.handle(e).failure);
      }
    } else {
      yield Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


  @override
  Future<Either<Failure, void>> saveMyLocation(Passenger passenger) async{
    if(passenger.uid == null){
      await getPassenger();
    }
     if(await networkInfo.isConnected()){
       try{
         var result = await apiClient.saveMyLocation(passenger);
         return Right(result);
       } catch(e){
         return Left(ErrorHandler.handle(e).failure);
       }
     } else {
       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
     }
  }

  @override
  Future<Either<Failure, void>> shareMyLocation(Passenger passenger) async{
     if(await networkInfo.isConnected()){
       try{
         var result = await apiClient.shareMyLocation(passenger);
         return Right(result);
       } catch(e){
         return Left(ErrorHandler.handle(e).failure);
       }
     } else {
       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
     }
  }

  @override
  Future<Either<Failure, Passenger>> getPassenger() async {
    if(await networkInfo.isConnected()){
      try{
        var result = await apiClient.getPassenger();
        return Right(result);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
   Stream<Either<Failure,List<Trip>>> getTrips() async* {
     if (await networkInfo.isConnected()) {
       try {
           await for (var result in apiClient.getTrips()) {
             yield Right(result);
           }
       } catch (e) {
         yield Left(ErrorHandler
             .handle(e)
             .failure);
       }
     } else {
       yield Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
     }
   }

  @override
  Future<Either<Failure, void>> updateTrip(Trip trip) async{
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
  Stream<Either<Failure, Driver>> getDriverStream(String driverId) async* {
    if (await networkInfo.isConnected()) {
      try {
        await for (var result in apiClient.getDriverStream(driverId)) {
          yield Right(result);
        }
      } catch (e) {
        yield Left(ErrorHandler
            .handle(e)
            .failure);
      }
    } else {
      yield Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}