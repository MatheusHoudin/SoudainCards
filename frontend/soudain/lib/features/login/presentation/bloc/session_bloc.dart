import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/validation/validation.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/domain/usecases/create_facebook_session_use_case.dart';
import 'package:soudain/features/login/domain/usecases/create_google_session_use_case.dart';
import 'package:soudain/features/login/domain/usecases/create_session_use_case.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final CreateSessionUseCase createSessionUseCase;
  final CreateFacebookSessionUseCase createFacebookSessionUseCase;
  final CreateGoogleSessionUseCase createGoogleSessionUseCase;

  SessionBloc({
    this.createSessionUseCase,
    this.createFacebookSessionUseCase,
    this.createGoogleSessionUseCase
  });

  @override
  SessionState get initialState => SessionFormState(emailFieldError: null, passwordFieldError: null, isCreatingSession: false);

  @override
  Stream<SessionState> mapEventToState(
    SessionEvent event,
  ) async* {
    if( event is CreateSessionEvent ) {
      print('CREATE SESSION');
      final emailIsValid = validateEmail(event.emailValue);
      final passwordIsValid = validatePassword(event.passwordValue);

      if(emailIsValid && passwordIsValid) {
        yield SessionFormState(
          passwordFieldError: null,
          emailFieldError: null,
          isCreatingSession: true
        );

        final failureOrSession = await createSessionUseCase(CreateSessionParams(
          email: event.emailValue,
          password: event.passwordValue
        ));

        yield* failureOrSession.fold(
          (failure) async*{
            print(failure);
            if (failure is EmailNotRegisteredFailure) {

              yield SessionFormState(
                passwordFieldError: null,
                emailFieldError: emailIsNotRegistered,
                isCreatingSession: false
              );
            } else if (failure is PasswordDoesNotMatchFailure) {
              yield SessionFormState(
                passwordFieldError: passwordDoesNotMatchWithEmail,
                emailFieldError: null,
                isCreatingSession: false
              );
            } else {
              yield SessionFormState(
                passwordFieldError: null,
                emailFieldError: null,
                isCreatingSession: false,
              );
              String message = failure is ServerFailure ? unexpectedServerError : noInternetConnection;
              event.onServerError(message);
            }
            event.loginFormKey.currentState.validate();
          },
          (session) async* {
            event.onSuccess();
          }
        );
      }else{
        yield SessionFormState(
          emailFieldError: !emailIsValid ? emailIsNotValid : null,
          passwordFieldError: !passwordIsValid ? passwordIsNotValid : null,
          isCreatingSession: false
        );
        event.loginFormKey.currentState.validate();
      }
    }else if(event is ValidateFieldsOnFocusLostEvent) {
      final emailIsValid = validateEmail(event.email);
      final passwordIsValid = validatePassword(event.password);

      yield SessionFormState(
        emailFieldError: !emailIsValid ? emailIsNotValid : null,
        passwordFieldError: !passwordIsValid ? passwordIsNotValid : null,
        isCreatingSession: false
      );
      event.signInFormKey.currentState.validate();
    }else if(event is CreateFacebookSessionEvent) {
      yield SessionFormState(
        passwordFieldError: null,
        emailFieldError: null,
        isCreatingSession: true
      );

      final result = await createFacebookSessionUseCase(FacebookParams());

      yield* result.fold(
        (failure) async* {
          if(failure is FacebookLoginCancelledByUserFailure) {
            yield SessionFormState(
              passwordFieldError: null,
              emailFieldError: null,
              isCreatingSession: false,
            );
          }else if(failure is EmailAlreadyRegisteredFailure){
            yield SessionFormState(
              passwordFieldError: null,
              emailFieldError: null,
              isCreatingSession: false,
            );
            event.onFailure(emailAlreadyRegistered);
          }else{
            yield SessionFormState(
              passwordFieldError: null,
              emailFieldError: null,
              isCreatingSession: false,
            );
            String message = failure is ServerFailure ? unexpectedServerError : noInternetConnection;
            event.onServerError(message);
          }
        },
        (session) async* {
          event.onSuccess();
        }
      );
    }else if(event is CreateGoogleSessionEvent) {
      yield SessionFormState(
        passwordFieldError: null,
        emailFieldError: null,
        isCreatingSession: true
      );

      final result = await createGoogleSessionUseCase(GoogleParams());
      yield* result.fold(
         (failure) async* {
            if(failure is GoogleLoginCancelledByUserFailure) {
              yield SessionFormState(
                passwordFieldError: null,
                emailFieldError: null,
                isCreatingSession: false,
              );
            }else if(failure is EmailAlreadyRegisteredFailure){
              yield SessionFormState(
                passwordFieldError: null,
                emailFieldError: null,
                isCreatingSession: false,
              );
              event.onFailure(emailAlreadyRegistered);
            }else{
              yield SessionFormState(
                passwordFieldError: null,
                emailFieldError: null,
                isCreatingSession: false,
              );
              String message = failure is ServerFailure ? unexpectedServerError : noInternetConnection;
              event.onServerError(message);
            }
         },
         (session) async* {
            event.onSuccess();
         }
      );
    }
  }
}
