import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/network/network_info.dart';
import 'package:soudain/features/forgot_password/data/datasources/forgot_password_remote_data_source.dart';
import 'package:soudain/features/forgot_password/data/model/forgot_password_confirmation_model.dart';
import 'package:soudain/features/forgot_password/domain/repository/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository {
  ForgotPasswordRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  ForgotPasswordRepositoryImpl({
    this.remoteDataSource,
    this.networkInfo
  });

  @override
  Future<Either<Failure, ForgotPasswordConfirmationModel>> resetPassword(String email) async{
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.requestPasswordReset(email);

        return Right(result);
      } on EmailNotRegisteredException {
        return Left(EmailNotRegisteredFailure());
      } on ServerException {
        return Left(ServerFailure());
      } on PasswordResetRequestMalformedException catch(e) {
        return Left(PasswordResetRequestMalformedFailure(parameterErrorList: e.parameterErrorList));
      }
    }else{
      return Left(NoInternetConnectionFailure());
    }
  }

}