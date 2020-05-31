
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/error/field_error.dart';
import 'package:soudain/core/network/network_info.dart';
import 'package:soudain/features/login/data/datasource/session_local_data_source.dart';
import 'package:soudain/features/login/data/datasource/session_remote_data_source.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/data/repository/session_repository_impl.dart';
import 'package:soudain/features/login/domain/repository/session_repository.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSessionLocalDataSource extends Mock implements SessionLocalDataSource {}
class MockSessionRemoteDataSource extends Mock implements SessionRemoteDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main(){
  MockSessionLocalDataSource sessionLocalDataSource;
  MockSessionRemoteDataSource sessionRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  SessionRepository sessionRepository;

  setUp((){
    sessionRemoteDataSource = MockSessionRemoteDataSource();
    sessionLocalDataSource = MockSessionLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    sessionRepository = SessionRepositoryImpl(
      sessionLocalDataSource: sessionLocalDataSource,
      sessionRemoteDataSource: sessionRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  test(
    'Should return a NoInternetConnectionFailure when there is no internet connection',
    () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await sessionRepository.createSession(email: 'email', password: 'password');

      expect(result, Left(NoInternetConnectionFailure()));
    }
  );


  group('createSession', (){

    setUp((){when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);});

    SessionModel sessionModel = SessionModel.fromJson(json.decode(convertJsonToString('session.json')));
    FieldError parameterError = FieldError.fromJson(json.decode(convertJsonToString('parameter_error.json')));

    test(
      'Should call the createSession method from SessionRemoteDataSource with the email and password provided',
      () async {
        await sessionRepository.createSession(email: 'email', password: 'password');

        verify(sessionRemoteDataSource.createSession(email: 'email', password: 'password'));
      }
    );

    test(
      'Should save the session by calling the cacheSession method from SessionLocalDataSource when creating a session is successfull',
      () async {
        when(sessionRemoteDataSource.createSession(email: 'email', password: 'password'))
            .thenAnswer((_) async => sessionModel);

        final result = await sessionRepository.createSession(email: 'email', password: 'password');

        expect(result, Right(sessionModel));
        verify(sessionLocalDataSource.cacheSession(sessionModel));
      }
    );

    test(
      'Should return a EmailNotRegisteredFailure when a EmailNotRegisteredException is thrown by SessionRemoteDataSource',
      () async {
        when(sessionRemoteDataSource.createSession(email: 'email', password: 'password'))
            .thenThrow(EmailNotRegisteredException());

        final result = await sessionRepository.createSession(email: 'email', password: 'password');

        expect(result, Left(EmailNotRegisteredFailure()));
        verifyZeroInteractions(sessionLocalDataSource);
      }
    );

    test(
      'Should return a PasswordDoesNotMatchFailure when a PasswordDoesNotMatchException is thrown by SessionRemoteDataSource',
      () async {
        when(sessionRemoteDataSource.createSession(email: 'email', password: 'password'))
            .thenThrow(PasswordDoesNotMatchException());

        final result = await sessionRepository.createSession(email: 'email', password: 'password');

        expect(result, Left(PasswordDoesNotMatchFailure()));
        verifyZeroInteractions(sessionLocalDataSource);
      }
    );

    test(
      'Should return a ServerException when a ServerFailure is thrown by SessionRemoteDataSource',
      () async {
        when(sessionRemoteDataSource.createSession(email: 'email', password: 'password'))
            .thenThrow(ServerException());

        final result = await sessionRepository.createSession(email: 'email', password: 'password');

        expect(result, Left(ServerFailure()));
        verifyZeroInteractions(sessionLocalDataSource);
      }
    );

    test(
      'Should return a SessionRequestMalformedFailure when a ServerFailure is thrown by SessionRequestMalformedException',
      () async {
        when(sessionRemoteDataSource.createSession(email: 'email', password: 'password'))
            .thenThrow(SessionRequestMalformedException(
          parameterErrorList: [
            parameterError,
            parameterError
          ]
        ));

        final result = await sessionRepository.createSession(email: 'email', password: 'password');

        expect(result, Left(SessionRequestMalformedFailure(
          parameterErrorList: [
            parameterError,
            parameterError
          ]
        )));
        verifyZeroInteractions(sessionLocalDataSource);
      }
    );
  });

  group('getCachedSession', () {
    SessionModel sessionModel = SessionModel.fromJson(json.decode(convertJsonToString('session.json')));
    test(
      'Should return the current cached SessionModel',
      () async {

        when(sessionLocalDataSource.getCachedSession())
            .thenAnswer((_) async => sessionModel);

        final result = await sessionRepository.getCachedSession();

        expect(result, Right(sessionModel));
        verify(sessionLocalDataSource.getCachedSession());
      }
    );

    test(
      'Should return a SessionDoesNotExistFailure when a SessionDoesNotExistException is thrown by SessionLocalDataSource',
      () async {
        when(sessionLocalDataSource.getCachedSession())
            .thenThrow(SessionDoesNotExistException());

        final result = await sessionRepository.getCachedSession();

        expect(result, Left(SessionDoesNotExistFailure()));
      }
    );
  });
}