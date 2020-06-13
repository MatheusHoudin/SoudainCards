import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/forgot_password/data/model/forgot_password_confirmation_model.dart';
import 'package:soudain/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:soudain/features/forgot_password/domain/usecase/forgot_password_use_case.dart';
import 'package:soudain/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockForgotPasswordUseCase extends Mock implements ForgotPasswordUseCase {}

void main() {
  MockForgotPasswordUseCase useCase;
  ForgotPasswordBloc bloc;
  ForgotPasswordConfirmationModel model;

  setUp((){
    model = ForgotPasswordConfirmationModel.fromJson(json.decode(convertJsonToString('forgot_password_confirmation.json')));
    useCase = MockForgotPasswordUseCase();
    bloc = ForgotPasswordBloc(useCase: useCase);
  });

  test(
    'Initial state should not have emailError and isRequestingPasswordReset set to false',
    () async {
      expect(bloc.initialState, ForgotPasswordFormState(emailError: null, isRequestingPasswordReset: false));
    }
  );

  test(
    'Should return ForgotPasswordFormState with emailError when the provided email is not valid',
    () async {
      final expected = [
        ForgotPasswordFormState(emailError: null, isRequestingPasswordReset: false),
        ForgotPasswordFormState(emailError: emailIsNotValid, isRequestingPasswordReset: true),
      ];

      expectLater(bloc.cast(), emitsInOrder(expected));

      bloc.add(RequestPasswordResetEvent(email: 'email@email.com'));
    }
  );

  test(
    'Should cancel the isRequestingPasswordReset when call to the repository is successful',
    () async {
      when(useCase(ForgotPasswordParams(email: 'email@email.com')))
      .thenAnswer((_) async => Right(model));

      final expected = [
        ForgotPasswordFormState(emailError: null, isRequestingPasswordReset: false),
        ForgotPasswordFormState(emailError: null, isRequestingPasswordReset: true),
        ForgotPasswordFormState(emailError: null, isRequestingPasswordReset: false),
      ];

      expectLater(bloc.cast(), emitsInOrder(expected));

      bloc.add(RequestPasswordResetEvent(email: 'email@email.com'));
    }
  );

  test(
    'Should return ForgotPasswordFormState with email error when the email is not registered',
    () async {
      when(useCase(ForgotPasswordParams(email: 'email@email.com')))
      .thenAnswer((_) async => Left(EmailNotRegisteredFailure()));

      final expected = [
        ForgotPasswordFormState(emailError: null, isRequestingPasswordReset: false),
        ForgotPasswordFormState(emailError: null, isRequestingPasswordReset: true),
        ForgotPasswordFormState(emailError: emailIsNotRegistered, isRequestingPasswordReset: false),
      ];

      expectLater(bloc.cast(), emitsInOrder(expected));

      bloc.add(RequestPasswordResetEvent(email: 'email@email.com'));
    }
  );

  test(
    'Should emit a ForgotPasswordFormState with no emailError and isRequestingPasswordReset set to false',
    () async {
      when(useCase(ForgotPasswordParams(email: 'email@email.com')))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        ForgotPasswordFormState(emailError: null, isRequestingPasswordReset: false),
        ForgotPasswordFormState(emailError: null, isRequestingPasswordReset: true),
        ForgotPasswordFormState(emailError: null, isRequestingPasswordReset: false),
      ];


      expectLater(bloc.cast(), emitsInOrder(expected));

      bloc.add(RequestPasswordResetEvent(email: 'email@email.com'));
    }
  );
}