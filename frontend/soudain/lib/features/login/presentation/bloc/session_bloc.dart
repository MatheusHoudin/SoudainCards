import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/validation/validation.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/domain/usecases/create_session_use_case.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final CreateSessionUseCase createSessionUseCase;

  SessionBloc({
    this.createSessionUseCase
  });
  @override
  SessionState get initialState => FormState(emailFieldError: null, passwordFieldError: null);

  @override
  Stream<SessionState> mapEventToState(
    SessionEvent event,
  ) async* {
    if( event is CreateSessionEvent ) {
      final emailIsValid = validateEmail(event.emailValue);
      final passwordIsValid = validatePassword(event.passwordValue);

      if(emailIsValid && passwordIsValid) {
        yield CreatingSessionState();

        final failureOrSession = await createSessionUseCase(CreateSessionParams(
          email: event.emailValue,
          password: event.passwordValue
        ));

        yield* failureOrSession.fold(
          (failure) async*{
            if (failure is EmailNotRegisteredFailure) {
              yield FormState(
                passwordFieldError: null,
                emailFieldError: emailIsNotRegistered
              );
            } else if (failure is PasswordDoesNotMatchFailure) {
              yield FormState(
                passwordFieldError: passwordDoesNotMatchWithEmail,
                emailFieldError: null
              );
            } else {
              yield ErrorState(
                message: unexpectedServerError
              );
            }
          },
          (session) async* {
            yield SessionCreatedState(
              model: session
            );
          }
        );
      }else{
        yield FormState(
          emailFieldError: !emailIsValid ? emailIsNotValid : null,
          passwordFieldError: !passwordIsValid ? passwordIsNotValid : null
        );
      }
    }
  }
}
