import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/error/field_error.dart';
import 'package:soudain/features/login/data/datasource/session_remote_data_source.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';
import 'package:soudain/features/signup/data/datasource/signup_remote_datasource.dart';
import 'package:soudain/features/signup/data/repository/signup_repository_impl.dart';
import 'package:soudain/features/signup/domain/repository/signup_repository.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSignUpRemoteRepository extends Mock implements SignUpRemoteDataSource {}

void main(){
  MockSignUpRemoteRepository mockSessionRemoteRepository;
  SignUpRepository signUpRepository;
  UserModel userModel;
  FieldError parameterError;
  setUp((){
    userModel = UserModel.fromJson(json.decode(convertJsonToString('user.json')));
    parameterError = FieldError.fromJson(json.decode(convertJsonToString('parameter_error.json')));
    mockSessionRemoteRepository = MockSignUpRemoteRepository();
    signUpRepository = SignUpRepositoryImpl(
      signUpRemoteDataSource: mockSessionRemoteRepository
    );
  });

  group('signUp', () {

    test(
      'Sign up should be called with the provided parameters',
      () async {
        await signUpRepository.signUp(
          email: 'email',
          password: 'password',
          name: 'name',
          passwordConfirmation: 'password'
        );

        verify(mockSessionRemoteRepository.signUp(
          passwordConfirmation: 'password',
          name: 'name',
          password: 'password',
          email: 'email'
        ));
      }
    );

    test(
      'Should return Right with UserModel when sign up is successfull',
      () async {
        when(mockSessionRemoteRepository.signUp(
          email: 'email',
          password: 'password',
          name: 'name',
          passwordConfirmation: 'password'
        )).thenAnswer((_) async => userModel);

        final result = await signUpRepository.signUp(
          email: 'email',
          password: 'password',
          name: 'name',
          passwordConfirmation: 'password'
        );

        expect(result, Right(userModel));
      }
    );

    test(
      'Should return a Left with EmailAlreadyRegisteredFailure when a EmailAlreadyRegisteredException is thrown',
      () async {
        when(mockSessionRemoteRepository.signUp(
          email: 'email',
          password: 'password',
          name: 'name',
          passwordConfirmation: 'password'
        )).thenThrow(EmailAlreadyRegisteredException());

        final result = await signUpRepository.signUp(
          email: 'email',
          password: 'password',
          name: 'name',
          passwordConfirmation: 'password'
        );

        expect(result, Left(EmailAlreadyRegisteredFailure()));
      }
    );

    test(
      'Should return a Left with SessionRequestMalformedFailure when a SessionRequestMalformedException is thrown',
      () async {
        when(mockSessionRemoteRepository.signUp(
          email: 'email',
          password: 'password',
          name: 'name',
          passwordConfirmation: 'password'
        )).thenThrow(SessionRequestMalformedException(
            parameterErrorList: [
              parameterError,
              parameterError
            ]
        ));

        final result = await signUpRepository.signUp(
          email: 'email',
          password: 'password',
          name: 'name',
          passwordConfirmation: 'password'
        );

        expect(result, Left(SessionRequestMalformedFailure(
            parameterErrorList: [
              parameterError,
              parameterError
            ]
        )));
      }
    );

    test(
        'Should return a Left with ServerFailure when a ServerException is thrown',
            () async {
          when(mockSessionRemoteRepository.signUp(
              email: 'email',
              password: 'password',
              name: 'name',
              passwordConfirmation: 'password'
          )).thenThrow(ServerException());

          final result = await signUpRepository.signUp(
              email: 'email',
              password: 'password',
              name: 'name',
              passwordConfirmation: 'password'
          );

          expect(result, Left(ServerFailure()));
        }
    );
  });
}