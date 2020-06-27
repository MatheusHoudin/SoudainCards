import 'package:soudain/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:soudain/features/home/data/model/user_data_model.dart';
abstract class UserDataRepository {
  Future<Either<Failure, UserDataModel>> getUserData();
}