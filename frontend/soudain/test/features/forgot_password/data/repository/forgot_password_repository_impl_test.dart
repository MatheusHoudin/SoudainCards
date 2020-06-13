import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/network/network_info.dart';
import 'package:soudain/features/forgot_password/data/datasources/forgot_password_remote_data_source.dart';
import 'package:soudain/features/forgot_password/data/model/forgot_password_confirmation_model.dart';
import 'package:soudain/features/forgot_password/data/repository/forgot_password_repository_impl.dart';
import 'package:soudain/features/forgot_password/domain/repository/forgot_password_repository.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockForgotPasswordRemoteDataSource extends Mock implements ForgotPasswordRemoteDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}
void main() {
  MockForgotPasswordRemoteDataSource mockForgotPasswordRemoteDataSource;
  ForgotPasswordRepository forgotPasswordRepository;
  NetworkInfo networkInfo;
  ForgotPasswordConfirmationModel model;
  final String email = 'email';

  setUp((){
    networkInfo = MockNetworkInfo();
    model = ForgotPasswordConfirmationModel.fromJson(json.decode(convertJsonToString('forgot_password_confirmation.json')));
    mockForgotPasswordRemoteDataSource = MockForgotPasswordRemoteDataSource();
    forgotPasswordRepository = ForgotPasswordRepositoryImpl(
      remoteDataSource: mockForgotPasswordRemoteDataSource,
      networkInfo: networkInfo
    );
  });

  void setUpForgotPasswordSuccess() {
    when(mockForgotPasswordRemoteDataSource.requestPasswordReset(any))
        .thenAnswer((_) async => model);
  }

  test(
    'Should call requestPasswordReset on ForgotPasswordRemoteDataSource with the provided email',
    () async {
      when(networkInfo.isConnected)
          .thenAnswer((_) async => true);
      setUpForgotPasswordSuccess();
      await forgotPasswordRepository.resetPassword(email);

      verify(mockForgotPasswordRemoteDataSource.requestPasswordReset(email));
    }
  );

  test(
    'Should return Right with the ForgotPasswordConfirmationModel when call to api is successful',
    () async {
      when(networkInfo.isConnected)
          .thenAnswer((_) async => true);
      setUpForgotPasswordSuccess();
      final result = await forgotPasswordRepository.resetPassword(email);

      expect(result, Right(model));
    }
  );

  test(
    'Should return a Left with EmailNotRegisteredFailure when provided email is not associated with an account',
    () async {
      when(networkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(mockForgotPasswordRemoteDataSource.requestPasswordReset(any))
          .thenThrow(EmailNotRegisteredException());

      final result = await forgotPasswordRepository.resetPassword(email);

      expect(result, Left(EmailNotRegisteredFailure()));
    }
  );

  test(
    'Should return a Left with PasswordResetRequestMalformedFailure when the request is malformed with the provided fields',
    () async {
      when(networkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(mockForgotPasswordRemoteDataSource.requestPasswordReset(any))
          .thenThrow(PasswordResetRequestMalformedException());

      final result = await forgotPasswordRepository.resetPassword(email);

      expect(result, Left(PasswordResetRequestMalformedFailure()));
    }
  );

  test(
    'Should return a Left with ServerFailure when an error occurs on the server',
    () async {
      when(networkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(mockForgotPasswordRemoteDataSource.requestPasswordReset(any))
          .thenThrow(ServerException());

      final result = await forgotPasswordRepository.resetPassword(email);

      expect(result, Left(ServerFailure()));
    }
  );

  test(
    'Should return a Left with ServerFailure when the server is off',
    () async {
      when(networkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(mockForgotPasswordRemoteDataSource.requestPasswordReset(any))
          .thenThrow(ServerFailure());

      final result = await forgotPasswordRepository.resetPassword(email);

      expect(result, Left(ServerFailure()));
    }
  );

  test(
    'Should return a Left with NoInternetConnectionFailure when there is no internet connection on the device',
    () async {
      when(networkInfo.isConnected)
          .thenAnswer((_) async => false);

      final result = await forgotPasswordRepository.resetPassword(email);

      expect(result, Left(NoInternetConnectionFailure()));
    }
  );
}