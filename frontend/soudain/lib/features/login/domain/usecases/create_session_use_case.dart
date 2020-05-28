import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/usecase/base_usecase.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/domain/repository/session_repository.dart';

class CreateSessionUseCase extends BaseUseCase<SessionModel, CreateSessionParams> {
  final SessionRepository sessionRepository;

  CreateSessionUseCase({this.sessionRepository});

  @override
  Future<Either<Failure, SessionModel>> call(CreateSessionParams params) async {
    final result = await sessionRepository.createSession(
        email: params.email,
        password: params.password
    );

    return result;
  }

}

class CreateSessionParams extends Equatable {
  final String email;
  final String password;

  CreateSessionParams({this.email,this.password});

  @override
  List<Object> get props => [this.email, this.password];

}