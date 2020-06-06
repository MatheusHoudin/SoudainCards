import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/validation/validation.dart';
import 'package:soudain/features/signup/domain/usecase/sign_up_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase useCase;

  SignUpBloc({this.useCase});

  @override
  SignUpState get initialState => SignUpFormState(
    emailError: null,
    nameError: null,
    passwordConfirmationError: null,
    passwordError: null,
    isCreatingAccount: false
  );

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is CreateAccountEvent) {
      bool nameIsValid = validateName(event.name);
      bool emailIsValid = validateEmail(event.email);
      bool passwordIsValid = validatePassword(event.password);
      bool passwordMatches = comparePasswords(event.password,event.passwordConfirmation);

      bool fieldsAreValid = nameIsValid && emailIsValid && passwordIsValid && passwordMatches;

      if(fieldsAreValid) {
        yield SignUpFormState(
          emailError: null,
          nameError: null,
          passwordConfirmationError: null,
          passwordError: null,
          isCreatingAccount: true
        );

        final result = await useCase(SignUpParams(
          email: event.email,
          password: event.password,
          name: event.name,
          passwordConfirmation: event.passwordConfirmation
        ));

        yield* result.fold(
          (failure) async* {
            if(failure is EmailAlreadyRegisteredFailure){
              yield SignUpFormState(
                emailError: emailAlreadyRegistered,
                passwordConfirmationError: null,
                passwordError: null,
                nameError: null,
                isCreatingAccount: false
              );
            }else{
              yield SignUpFormState(
                emailError: null,
                passwordConfirmationError: null,
                passwordError: null,
                nameError: null,
                isCreatingAccount: false
              );
              String message = failure is ServerFailure ? unexpectedServerError : noInternetConnection;
              event.onServerError(message);
            }
            event.signUpFormKey.currentState.validate();
          },
          (userModel) async* {
            event.onSuccess();
          }
        );
      }else{
        yield SignUpFormState(
          nameError: nameIsValid ? null : nameIsNotValid,
          passwordError: passwordIsValid ? null : passwordIsNotValid,
          emailError: emailIsValid ? null : emailIsNotValid,
          passwordConfirmationError: passwordMatches ? null : passwordDoesNotMatchConfirmationPassword,
          isCreatingAccount: false
        );
        event.signUpFormKey.currentState.validate();
      }
    }else if(event is ValidateFieldsOnFocusLostEvent) {
      bool nameIsValid = validateName(event.name);
      bool emailIsValid = validateEmail(event.email);
      bool passwordIsValid = validatePassword(event.password);
      bool passwordMatches = comparePasswords(event.password,event.passwordConfirmation);

      print(event.email);
      yield SignUpFormState(
        nameError: nameIsValid ? null : nameIsNotValid,
        passwordError: passwordIsValid ? null : passwordIsNotValid,
        emailError: emailIsValid ? null : emailIsNotValid,
        passwordConfirmationError: passwordMatches ? null : passwordDoesNotMatchConfirmationPassword,
        isCreatingAccount: false
      );
      event.signUpFormKey.currentState.validate();
    }
  }
}
