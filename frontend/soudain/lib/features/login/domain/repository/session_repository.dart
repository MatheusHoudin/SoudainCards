import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:dartz/dartz.dart';

abstract class SessionRepository {
  Future<Either<Failure,SessionModel>> getCachedSession();
  Future<Either<Failure,SessionModel>> createSession({String email, String password});
  Future<Either<Failure,void>> deleteCachedSession();
}