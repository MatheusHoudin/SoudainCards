import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/validation/validation.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/domain/usecases/create_session_use_case.dart';
import 'package:soudain/features/login/presentation/bloc/session_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockCreateSessionUseCase extends Mock implements CreateSessionUseCase {}

void main(){
  MockCreateSessionUseCase createSessionUseCase;
  SessionBloc bloc;
  final model = SessionModel.fromJson(json.decode(convertJsonToString('session.json')));
  setUp((){
    createSessionUseCase = MockCreateSessionUseCase();
    bloc = SessionBloc(createSessionUseCase: createSessionUseCase);
  });

  test(
    'State should be FormState with null fields',
    () async {
      expect(bloc.initialState, SessionFormState(passwordFieldError: null, emailFieldError: null, isCreatingSession: false));
    }
  );

  group('createSessionUseCase', (){

    test(
      'Should yield a FormState with email error when the email provided is not valid',
      () async {

        final expected = [
          SessionFormState(emailFieldError: null, passwordFieldError: null, isCreatingSession: false),
          SessionFormState(emailFieldError: emailIsNotValid, passwordFieldError: null, isCreatingSession: false)
        ];
        
        expectLater(bloc.cast(), emitsInOrder(expected));
        bloc.add(CreateSessionEvent(
          emailValue: 'email',
          passwordValue: 'password',
          loginFormKey: GlobalKey<FormState>()
        ));
      }
    );

    test(
      'Should yield a FormState with password error when the password provided is not valid',
      () async {
        final expected = [
          SessionFormState(emailFieldError: null, passwordFieldError: null, isCreatingSession: false),
          SessionFormState(emailFieldError: null, passwordFieldError: passwordIsNotValid)
        ];

        expectLater(bloc.cast(), emitsInOrder(expected));
        bloc.add(CreateSessionEvent(
          emailValue: 'email@email.com',
          passwordValue: 'pass'
        ));
      }
    );

    test(
      'Create Session should be called with the provided fields when fields are valid',
      () async {
        when(createSessionUseCase(any))
            .thenAnswer((_) async => Right(model));

        final expected = [
          SessionFormState(emailFieldError: null, passwordFieldError: null),
        ];

        expectLater(bloc.cast(), emitsInAnyOrder(expected));
        bloc.add(CreateSessionEvent(
          emailValue: 'email@email.com',
          passwordValue: 'password'
        ));

        await untilCalled(createSessionUseCase(CreateSessionParams(password: 'password', email: 'email@email.com')));
      }
    );

    test(
      'Should yield a EmailIsNotRegisteredFailure when provided email is not registered on database',
      () async {
        when(createSessionUseCase(any))
        .thenAnswer((_) async => Left(EmailNotRegisteredFailure()));

        final expected = [
          SessionFormState(passwordFieldError: null,emailFieldError: null),
          SessionFormState(passwordFieldError: null,emailFieldError: null, isCreatingSession: true),
          SessionFormState(passwordFieldError: null,emailFieldError: emailIsNotRegistered, isCreatingSession: false),
        ];

        expectLater(bloc.cast(), emitsInOrder(expected));
        bloc.add(CreateSessionEvent(
          emailValue: 'email@email.com',
          passwordValue: 'password'
        ));

        await untilCalled(createSessionUseCase(CreateSessionParams(password: 'password', email: 'email@email.com')));
      }
    );

    test(
      'Should yield a PasswordDoesNotMatchFailure when provided password does not match with the provided email',
      () async {
        when(createSessionUseCase(any))
            .thenAnswer((_) async => Left(PasswordDoesNotMatchFailure()));

        final expected = [
          SessionFormState(passwordFieldError: null,emailFieldError: null),
          SessionFormState(passwordFieldError: null,emailFieldError: null, isCreatingSession: true),
          SessionFormState(passwordFieldError: passwordDoesNotMatchWithEmail,emailFieldError: null, isCreatingSession: false),
        ];

        expectLater(bloc.cast(), emitsInOrder(expected));
        bloc.add(CreateSessionEvent(
          emailValue: 'email@email.com',
          passwordValue: 'password'
        ));

        await untilCalled(createSessionUseCase(CreateSessionParams(password: 'password', email: 'email@email.com')));
      }
    );

    test(
      'Should yield a ServerFailure when a failure occurs on the server side',
      () async {
        when(createSessionUseCase(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        final expected = [
          SessionFormState(passwordFieldError: null,emailFieldError: null),
          SessionFormState(passwordFieldError: null,emailFieldError: null, isCreatingSession: true),
          SessionFormState(passwordFieldError: null,emailFieldError: null, isCreatingSession: false),
        ];

        expectLater(bloc.cast(), emitsInOrder(expected));
        bloc.add(CreateSessionEvent(
          emailValue: 'email@email.com',
          passwordValue: 'password'
        ));

        await untilCalled(createSessionUseCase(CreateSessionParams(password: 'password', email: 'email@email.com')));
      }
    );

    test(
      'Should yield a SessionCreatedState when the user can log in successfully',
      () async {

        when(createSessionUseCase(any))
            .thenAnswer((_) async => Right(model));

        final expected = [
          SessionFormState(passwordFieldError: null,emailFieldError: null),
          SessionFormState(passwordFieldError: null,emailFieldError: null, isCreatingSession: true),
        ];

        expectLater(bloc.cast(), emitsInOrder(expected));
        bloc.add(CreateSessionEvent(
          emailValue: 'email@email.com',
          passwordValue: 'password'
        ));

        await untilCalled(createSessionUseCase(CreateSessionParams(password: 'password', email: 'email@email.com')));
      }
    );

  });
}