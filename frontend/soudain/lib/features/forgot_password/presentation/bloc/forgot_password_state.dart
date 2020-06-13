part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordFormState extends ForgotPasswordState {
  final String emailError;
  final bool isRequestingPasswordReset;

  ForgotPasswordFormState({
    this.emailError,
    this.isRequestingPasswordReset
  });

  @override
  List<Object> get props => [
    this.emailError,
    this.isRequestingPasswordReset
  ];
}
