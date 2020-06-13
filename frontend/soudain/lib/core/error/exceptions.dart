import 'package:soudain/core/error/field_error.dart';

class EmailNotRegisteredException implements Exception {}

class EmailAlreadyRegisteredException implements Exception {}

class PasswordDoesNotMatchException implements Exception {}

class SessionRequestMalformedException implements Exception {
  final List<FieldError> parameterErrorList;

  SessionRequestMalformedException({
    this.parameterErrorList
  });
}

class PasswordResetRequestMalformedException implements Exception {
  final List<FieldError> parameterErrorList;

  PasswordResetRequestMalformedException({
    this.parameterErrorList
  });
}

class SignUpRequestMalformedException implements Exception {
  final List<FieldError> parameterErrorList;

  SignUpRequestMalformedException({
    this.parameterErrorList
  });
}

class SessionDoesNotExistException implements Exception {}

class ServerException implements Exception {}

class FacebookLoginCancelledByUserException implements Exception {}

class GoogleLoginCancelledByUserException implements Exception {}