import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/usecase/base_usecase.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/domain/repository/session_repository.dart';

class CreateGoogleSessionUseCase extends BaseUseCase<SessionModel, GoogleParams> {
  final SessionRepository sessionRepository;

  CreateGoogleSessionUseCase({this.sessionRepository});

  @override
  Future<Either<Failure, SessionModel>> call(GoogleParams params) async {
    final result = await sessionRepository.createGoogleSession();

    return result;
  }

}

class GoogleParams extends Equatable {

  @override
  List<Object> get props => [];

}