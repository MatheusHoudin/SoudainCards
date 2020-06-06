import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/usecase/base_usecase.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/domain/repository/session_repository.dart';

class CreateFacebookSessionUseCase extends BaseUseCase<SessionModel, FacebookParams> {
  final SessionRepository sessionRepository;

  CreateFacebookSessionUseCase({this.sessionRepository});

  @override
  Future<Either<Failure, SessionModel>> call(FacebookParams params) async {
    final result = await sessionRepository.createFacebookSession();

    return result;
  }

}

class FacebookParams extends Equatable {

  @override
  List<Object> get props => [];

}