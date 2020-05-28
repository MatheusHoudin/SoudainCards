import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/domain/repository/session_repository.dart';
import 'package:soudain/features/login/domain/usecases/create_session_use_case.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

void main() {
  MockSessionRepository mockSessionRepository;
  CreateSessionUseCase createSessionUseCase;

  setUp((){
    mockSessionRepository = MockSessionRepository();
    createSessionUseCase = CreateSessionUseCase(sessionRepository: mockSessionRepository);
  });
  SessionModel sessionModel = SessionModel.fromJson(json.decode(convertJsonToString('session.json')));
  test(
    'Should call the createSession method from SessionRepository with the given parameters',
    () async {
      await createSessionUseCase.call(CreateSessionParams(email: 'email', password: 'password'));

      verify(mockSessionRepository.createSession(email: 'email',password: 'password'));
      verifyNoMoreInteractions(mockSessionRepository);
    }
  );

  test(
    'Should return SessionModel when call to the createSession from SessionRepository is successfull',
    () async {
      when(mockSessionRepository.createSession(password: 'password',email: 'email'))
          .thenAnswer((_) async => Right(sessionModel));

      final result = await createSessionUseCase(CreateSessionParams(email: 'email', password: 'password'));

      expect(result, Right(sessionModel));
      verify(mockSessionRepository.createSession(email: 'email',password: 'password'));
      verifyNoMoreInteractions(mockSessionRepository);
    }
  );

  test(
    'Should return SessionModel when call to the createSession from SessionRepository is successfull',
    () async {
      when(mockSessionRepository.createSession(password: 'password',email: 'email'))
          .thenAnswer((_) async => Left(ServerFailure()));

      final result = await createSessionUseCase(CreateSessionParams(email: 'email', password: 'password'));

      expect(result, Left(ServerFailure()));
      verify(mockSessionRepository.createSession(email: 'email',password: 'password'));
      verifyNoMoreInteractions(mockSessionRepository);
    }
  );
}