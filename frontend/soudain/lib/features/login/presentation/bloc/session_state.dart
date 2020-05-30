part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();
}

class SessionFormState extends SessionState {
  final String emailFieldError;
  final String passwordFieldError;
  final String error;
  final bool isCreatingSession;

  SessionFormState({
    this.emailFieldError,
    this.passwordFieldError,
    this.isCreatingSession,
    this.error
  });

  @override
  List<Object> get props => [
    this.passwordFieldError,
    this.emailFieldError,
    this.isCreatingSession,
    this.error
  ];
}

class SessionCreatedState extends SessionState{
  final SessionModel model;

  SessionCreatedState({this.model});

  @override
  List<Object> get props => [model];
}