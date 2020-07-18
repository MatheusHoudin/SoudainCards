import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/network/network_info.dart';
import 'package:soudain/features/collection/create/data/datasources/collection_remote_data_source.dart';
import 'package:soudain/features/collection/create/data/models/collection.dart';
import 'package:soudain/features/collection/create/domain/repository/collection_repository.dart';
import 'package:soudain/features/login/data/datasource/session_local_data_source.dart';

class CollectionRepositoryImpl extends CollectionRepository {
  final CollectionRemoteDataSource remoteDataSource;
  final SessionLocalDataSource sessionLocalDataSource;
  final NetworkInfo networkInfo;

  CollectionRepositoryImpl({this.remoteDataSource,this.sessionLocalDataSource,this.networkInfo});

  @override
  Future<Either<Failure, Collection>> save(Collection collection) async {
    if(await networkInfo.isConnected) {
      try {
        final sessionModel = await sessionLocalDataSource.getCachedSession();
        final result = await remoteDataSource.save(collection, sessionModel.token);

        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      } on ImageDoesNotExistException {
        return Left(ImageDoesNotExistFailure());
      } on CollectionAlreadyExistsException {
        return Left(CollectionAlreadyExistsFailure());
      }
    }else{
      return Left(NoInternetConnectionFailure());
    }
  }

}