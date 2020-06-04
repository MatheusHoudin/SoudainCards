import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/network/network_info.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';
import 'package:soudain/features/signup/data/datasource/signup_remote_datasource.dart';
import 'package:soudain/features/signup/domain/repository/signup_repository.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  final SignUpRemoteDataSource signUpRemoteDataSource;
  final NetworkInfo networkInfo;

  SignUpRepositoryImpl({this.signUpRemoteDataSource, this.networkInfo});

  @override
  Future<Either<Failure, UserModel>> signUp({String name, String email, String password, String passwordConfirmation}) async {
    if(await networkInfo.isConnected) {
      try {
        final result = await signUpRemoteDataSource.signUp(
            email: email,
            password: password,
            name: name,
            passwordConfirmation: passwordConfirmation
        );

        return Right(result);
      } on EmailAlreadyRegisteredException {
        return Left(EmailAlreadyRegisteredFailure());
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