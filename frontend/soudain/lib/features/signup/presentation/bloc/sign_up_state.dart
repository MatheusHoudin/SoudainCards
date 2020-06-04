part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpFormState extends SignUpState {
  final String nameError;
  final String emailError;
  final String passwordError;
  final String passwordConfirmationError;
  final bool isCreatingAccount;

  SignUpFormState({
    this.nameError,
    this.emailError,
    this.isCreatingAccount,
    this.passwordConfirmationError,
    this.passwordError
  });

  @override
  List<Object> get props => [
    this.nameError,
    this.passwordError,
    this.emailError,
    this.passwordConfirmationError,
    this.isCreatingAccount
  ];
}
