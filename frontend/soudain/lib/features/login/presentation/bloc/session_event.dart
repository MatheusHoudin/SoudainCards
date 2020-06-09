part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();
}

class ValidateFieldsOnFocusLostEvent extends SessionEvent {
  final String email;
  final String password;

  final GlobalKey<FormState> signInFormKey;

  ValidateFieldsOnFocusLostEvent({
    this.password,
    this.email,
    this.signInFormKey
  });

  @override
  List<Object> get props => [
    email,
    password,
  ];
}

class CreateFacebookSessionEvent extends SessionEvent {
  final Function onSuccess;
  final Function onServerError;

  CreateFacebookSessionEvent({this.onSuccess,this.onServerError});

  @override
  List<Object> get props => [];
}

class CreateSessionEvent extends SessionEvent {
  final String emailValue;
  final String passwordValue;
  final GlobalKey<FormState> loginFormKey;
  final Function onSuccess;
  final Function onServerError;

  CreateSessionEvent({
    this.emailValue,
    this.passwordValue,
    this.loginFormKey,
    this.onSuccess,
    this.onServerError
  });

  @override
  List<Object> get props => [
    this.emailValue,
    this.passwordValue
  ];

}