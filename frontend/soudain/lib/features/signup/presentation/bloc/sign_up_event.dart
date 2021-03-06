part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class ValidateFieldsOnFocusLostEvent extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final GlobalKey<FormState> signUpFormKey;

  ValidateFieldsOnFocusLostEvent({
    this.passwordConfirmation,
    this.name,
    this.password,
    this.email,
    this.signUpFormKey
  });

  @override
  List<Object> get props => [
    name,
    email,
    password,
    passwordConfirmation
  ];
}

class CreateAccountEvent extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final GlobalKey<FormState> signUpFormKey;
  final Function onSuccess;
  final Function onServerError;

  CreateAccountEvent({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.onServerError,
    this.onSuccess,
    this.signUpFormKey
  });

  @override
  List<Object> get props =>[
    this.name,
    this.email,
    this.passwordConfirmation,
    this.password
  ];

}