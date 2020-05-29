part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();
}

class FormState extends SessionState {
  final String emailFieldError;
  final String passwordFieldError;

  FormState({
    this.emailFieldError,
    this.passwordFieldError
  });

  @override
  List<Object> get props => [this.passwordFieldError,this.emailFieldError];
}

class CreatingSessionState extends SessionState {
  @override
  List<Object> get props => [];
}

class SessionCreatedState extends SessionState{
  final SessionModel model;

  SessionCreatedState({this.model});

  @override
  List<Object> get props => [model];
}

class ErrorState extends SessionState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [this.message];

}