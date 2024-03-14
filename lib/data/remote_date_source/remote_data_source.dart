import 'package:dartz/dartz.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/data/apiClient/api_client.dart';
import 'package:linkbus/data/apiClient/api_driver_client.dart';

import '../../core/errors/error_handler.dart';
import '../../core/errors/failure.dart';

abstract class DriverRemoteDataSource {
  Future<Either<Failure,bool>> signIn(String email, String password);
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
 

}