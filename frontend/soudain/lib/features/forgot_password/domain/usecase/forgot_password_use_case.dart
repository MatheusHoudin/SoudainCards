import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/usecase/base_usecase.dart';
import 'package:soudain/features/forgot_password/data/model/forgot_password_confirmation_model.dart';
import 'package:soudain/features/forgot_password/domain/repository/forgot_password_repository.dart';

class ForgotPasswordUseCase extends BaseUseCase<ForgotPasswordConfirmationModel, ForgotPasswordParams> {
  final ForgotPasswordRepository repository;

  ForgotPasswordUseCase({this.repository});

  @override
  Future<Either<Failure, ForgotPasswordConfirmationModel>> call(ForgotPasswordParams params) async {
    final result = await repository.resetPassword(params.email);

    return result;
  }

}

class ForgotPasswordParams extends Equatable {
  final String email;

  ForgotPasswordParams({this.email});

  @override
  List<Object> get props => [this.email];
}