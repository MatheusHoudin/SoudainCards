import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/usecase/base_usecase.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';
import 'package:soudain/features/signup/domain/repository/signup_repository.dart';

class SignUpUseCase extends BaseUseCase<UserModel, SignUpParams> {
  final SignUpRepository signUpRepository;

  SignUpUseCase({this.signUpRepository});

  @override
  Future<Either<Failure, UserModel>> call(SignUpParams params) async {
    final result = signUpRepository.signUp(
      passwordConfirmation: params.passwordConfirmation,
      name: params.name,
      password: params.password,
      email: params.email
    );

    return result;
  }

}

class SignUpParams extends Equatable{
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  SignUpParams({
    this.passwordConfirmation,
    this.password,
    this.email,
    this.name
  });

  @override
  List<Object> get props => [
    this.password,
    this.passwordConfirmation,
    this.name,
    this.email
  ];
}