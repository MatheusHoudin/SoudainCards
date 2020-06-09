import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/network/network_info.dart';
import 'package:soudain/features/login/data/datasource/session_local_data_source.dart';
import 'package:soudain/features/login/data/datasource/session_remote_data_source.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/domain/repository/session_repository.dart';

class SessionRepositoryImpl extends SessionRepository {
  final SessionLocalDataSource sessionLocalDataSource;
  final SessionRemoteDataSource sessionRemoteDataSource;
  final NetworkInfo networkInfo;

  SessionRepositoryImpl({
    this.sessionRemoteDataSource,
    this.sessionLocalDataSource,
    this.networkInfo
  });

  @override
  Future<Either<Failure, SessionModel>> createSession({String email, String password}) async {
    if (await networkInfo.isConnected) {
      try {
        SessionModel sessionModel = await sessionRemoteDataSource.createSession(
            email: email, password: password);
        await sessionLocalDataSource.cacheSession(sessionModel);
        return Right(sessionModel);
      } on EmailNotRegisteredException {
        return Left(EmailNotRegisteredFailure());
      } on PasswordDoesNotMatchException {
        return Left(PasswordDoesNotMatchFailure());
      } on SessionRequestMalformedException catch(e) {
        return Left(SessionRequestMalformedFailure(
            parameterErrorList: e.parameterErrorList
        ));
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(NoInternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCachedSession() async {
    await sessionLocalDataSource.deleteCachedSession();
    return Future.value();
  }

  @override
  Future<Either<Failure, SessionModel>> getCachedSession() async {
    try {
      final cachedSession = await sessionLocalDataSource.getCachedSession();
      return Right(cachedSession);
    } on SessionDoesNotExistException {
      return Left(SessionDoesNotExistFailure());
    }
  }

  @override
  Future<Either<Failure, SessionModel>> createFacebookSession() async {
    try {
      final sessionModel = await sessionRemoteDataSource.createFacebookSession();
      await sessionLocalDataSource.cacheSession(sessionModel);
      return Right(sessionModel);
    } on ServerException {
      return Left(ServerFailure());
    } on FacebookLoginCancelledByUserException {
      return Left(FacebookLoginCancelledByUserFailure());
    }
  }

}