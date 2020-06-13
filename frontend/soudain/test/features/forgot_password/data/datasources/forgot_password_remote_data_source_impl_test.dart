import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/features/forgot_password/data/datasources/forgot_password_remote_data_source.dart';
import 'package:soudain/features/forgot_password/data/model/forgot_password_confirmation_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  MockDio mockDio;
  ForgotPasswordRemoteDataSource dataSource;
  final String email = 'email';
  ForgotPasswordConfirmationModel passwordConfirmation;
  final dynamic request = {
    email: email
  };
  setUp(() {
    passwordConfirmation = ForgotPasswordConfirmationModel.fromJson(
      json.decode(convertJsonToString('forgot_password_confirmation.json'))
    );
    mockDio = MockDio();
    dataSource = ForgotPasswordRemoteDataSourceImpl(
      dio: mockDio
    );
  });

  void setUpRequestPasswordResetSuccessful() {
    when(mockDio.post(any, data:  request))
        .thenAnswer((_) async => Response(
        statusCode: 201,
        data: {
          "code": 201,
          "data": json.decode(convertJsonToString('forgot_password_confirmation.json')),
          "message": "message"
        }
    ));
  }
  
  test(
    'Should call the right endpoint when request a password reset',
    () async {
      setUpRequestPasswordResetSuccessful();
      
      await dataSource.requestPasswordReset(email);
      
      verify(mockDio.post('passwordreset',data: {'email': email}));
    }
  );

  test(
    'Should return ForgotPasswordConfirmation when call to api is successful',
    () async {
      setUpRequestPasswordResetSuccessful();

      final result = await dataSource.requestPasswordReset(email);

      expect(result, passwordConfirmation);
    }
  );

  test(
    'Should throw an EmailNotRegisteredException when provided email is not associated with a Soudain user',
    () async {
      when(mockDio.post(any, data: request))
          .thenThrow(DioError(
        response: Response(
            statusCode: 404,
            data: {
              "code": 404,
              "error": "error",
              "message": "error"
            }
        )
      ));

      final call = () => dataSource.requestPasswordReset(email);

      expect(() => call(), throwsA(TypeMatcher<EmailNotRegisteredException>()));
    }
  );

  test(
    'Should throw a SessionMalformedException the provided email is not valid',
    () async {
      when(mockDio.post(any, data: request))
          .thenThrow(DioError(
        response: Response(
            statusCode: 400,
            data: {
              "code": 400,
              "error": [
                {
                  "field": "email",
                  "message": "message"
                },
                {
                  "field": "password",
                  "message": "message"
                }
              ],
              "message": "error"
            }
        )
      ));

      final call = dataSource.requestPasswordReset;

      expect(() => call(email), throwsA(TypeMatcher<PasswordResetRequestMalformedException>()));
    }
  );

  test(
    'Should throw a ServerException when call to the server fails',
    () async {
      when(mockDio.post(any, data: request))
          .thenThrow(DioError(
        response: Response(
          statusCode: 500,
          data: {
            "code": 500,
            "error": "error",
            "message": "error"
          }
        )
      ));

      final call = dataSource.requestPasswordReset;

      expect(() => call(email), throwsA(TypeMatcher<ServerException>()));
    }
  );

  test(
    'Should throw a ServerException when trying to call the server when it is offline',
    () async {
      when(mockDio.post(any, data: request))
          .thenThrow(DioError());

      final call = () => dataSource.requestPasswordReset(email);
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    }
  );
}