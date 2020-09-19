import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/validation/validation.dart';
import 'package:soudain/features/forgot_password/domain/usecase/forgot_password_use_case.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase useCase;

  ForgotPasswordBloc({this.useCase});

  @override
  ForgotPasswordState get initialState => ForgotPasswordFormState(
      emailError: null, isRequestingPasswordReset: false);

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is RequestPasswordResetEvent) {
      bool emailIsValid = validateEmail(event.email);

      if (emailIsValid) {
        event.forgotPasswordFormKey.currentState.validate();
        yield ForgotPasswordFormState(
            emailError: null, isRequestingPasswordReset: true);

        final result = await useCase(ForgotPasswordParams(email: event.email));

        yield* result.fold((failure) async* {
          if (failure is EmailNotRegisteredFailure) {
            yield ForgotPasswordFormState(
                emailError: emailIsNotRegistered,
                isRequestingPasswordReset: false);
          } else {
            yield ForgotPasswordFormState(
                emailError: null, isRequestingPasswordReset: false);
            String message = failure is ServerFailure
                ? unexpectedServerError
                : noInternetConnection;
            event.onServerError(message);
          }
        }, (passwordResetConfirmation) async* {
          yield ForgotPasswordFormState(
              emailError: null, isRequestingPasswordReset: false);
          event.onSuccess(
              passwordResetSuccessfullInfo);
        });
      } else {
        yield ForgotPasswordFormState(
            emailError: emailIsNotValid, isRequestingPasswordReset: false);

        event.forgotPasswordFormKey.currentState.validate();
      }
    }
  }
}
