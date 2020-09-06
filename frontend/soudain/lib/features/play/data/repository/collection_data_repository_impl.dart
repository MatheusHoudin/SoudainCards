import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/network/network_info.dart';
import 'package:soudain/features/login/data/datasource/session_local_data_source.dart';
import 'package:soudain/features/play/data/datasource/collection_data_remote_data_source.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';
import 'package:soudain/features/play/domain/repository/collection_data_repository.dart';

class CollectionDataRepositoryImpl implements CollectionDataRepository {
  final CollectionDataRemoteDataSource remoteDataSource;
  final SessionLocalDataSource sessionLocalDataSource;
  final NetworkInfo networkInfo;

  CollectionDataRepositoryImpl({this.remoteDataSource,this.networkInfo,this.sessionLocalDataSource});

  @override
  Future<Either<Failure, List<CollectionData>>> getCollections() async{
    if(await networkInfo.isConnected) {
      try {
        final sessionModel = await sessionLocalDataSource.getCachedSession();
        final result = await remoteDataSource.getCollections(sessionModel.token);

        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(NoInternetConnectionFailure());
    }
  }
}