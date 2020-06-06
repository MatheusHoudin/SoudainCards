import 'package:soudain/features/login/data/model/user/user_model.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:dartz/dartz.dart';
abstract class SignUpRepository {
  Future<Either<Failure,UserModel>> signUp({String name, String email, String password, String passwordConfirmation});
}