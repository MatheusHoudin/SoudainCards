part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();
}

class FormState extends SessionState {
  final String loginFieldError;
  final String passwordFieldError;

  FormState({
    this.loginFieldError,
    this.passwordFieldError
  });

  @override
  List<Object> get props => [this.passwordFieldError,this.loginFieldError];
}

class CreatingSessionState extends SessionState {
  @override
  List<Object> get props => [];
}

class ErrorState extends SessionState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [this.message];

}