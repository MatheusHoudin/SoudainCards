import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';
import 'package:soudain/features/signup/domain/repository/signup_repository.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  @override
  Future<Either<Failure, UserModel>> signUp({String name, String email, String password, String passwordConfirmation}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithFacebook() {
    // TODO: implement signUpWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithGoogle() {
    // TODO: implement signUpWithGoogle
    throw UnimplementedError();
  }

  
}