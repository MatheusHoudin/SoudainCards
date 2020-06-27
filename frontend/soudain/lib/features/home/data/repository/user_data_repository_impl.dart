import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/network/network_info.dart';
import 'package:soudain/features/home/data/datasource/user_data_local_data_source.dart';
import 'package:soudain/features/home/data/datasource/user_data_remote_data_source.dart';
import 'package:soudain/features/home/data/model/user_data_model.dart';
import 'package:soudain/features/home/domain/repository/user_data_repository.dart';
import 'package:soudain/features/login/data/datasource/session_local_data_source.dart';

class UserDataRepositoryImpl extends UserDataRepository {
  final UserDataRemoteDataSource remoteDataSource;
  final UserDataLocalDataSource localDataSource;
  final SessionLocalDataSource sessionLocalDataSource;

  final NetworkInfo networkInfo;

  UserDataRepositoryImpl({
    this.localDataSource,
    this.remoteDataSource,
    this.networkInfo,
    this.sessionLocalDataSource
  });

  @override
  Future<Either<Failure, UserDataModel>> getUserData() async {
    final isConnected = await networkInfo.isConnected;

    try {
      if (isConnected) {
        final sessionModel = await sessionLocalDataSource.getCachedSession();
        final userData = await remoteDataSource.getUserData(sessionModel.userModel.id);
        await localDataSource.cacheUserData(userData);

        return Right(userData);
      }else{
        final cachedUserData = await localDataSource.getCachedUserData();
        return Right(cachedUserData);
      }
    } on UserDataDoesNotExistException {
      return Left(UserDataDoesNotExistFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}