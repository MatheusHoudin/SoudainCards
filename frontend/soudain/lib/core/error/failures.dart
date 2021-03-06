import 'package:equatable/equatable.dart';
import 'package:soudain/core/error/field_error.dart';

abstract class Failure extends Equatable{}

class EmailNotRegisteredFailure extends Failure {
  @override
  List<Object> get props => [];
}

class EmailAlreadyRegisteredFailure extends Failure {
  @override
  List<Object> get props => [];
}

class PasswordDoesNotMatchFailure extends Failure {
  @override
  List<Object> get props => [];
}

class SessionRequestMalformedFailure extends Failure {
  final List<FieldError> parameterErrorList;

  SessionRequestMalformedFailure({
    this.parameterErrorList
  });

  @override
  List<Object> get props => [parameterErrorList];
}

class SignUpRequestMalformedFailure extends Failure {
  final List<FieldError> parameterErrorList;

  SignUpRequestMalformedFailure({
    this.parameterErrorList
  });

  @override
  List<Object> get props => [parameterErrorList];
}

class PasswordResetRequestMalformedFailure extends Failure {
  final List<FieldError> parameterErrorList;

  PasswordResetRequestMalformedFailure({
    this.parameterErrorList
  });

  @override
  List<Object> get props => [parameterErrorList];
}

class SessionDoesNotExistFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UserDataDoesNotExistFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NoInternetConnectionFailure extends Failure {
  @override
  List<Object> get props => [];
}

class FacebookLoginCancelledByUserFailure extends Failure {
  @override
  List<Object> get props => [];
}

class GoogleLoginCancelledByUserFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ImageDoesNotExistFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CollectionAlreadyExistsFailure extends Failure {
  @override
  List<Object> get props => [];
}
