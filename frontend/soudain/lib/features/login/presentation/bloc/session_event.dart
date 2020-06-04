part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();
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