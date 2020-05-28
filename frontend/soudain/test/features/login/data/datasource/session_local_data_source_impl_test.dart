
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/hive/session_box.dart';
import 'package:soudain/features/login/data/datasource/session_local_data_source.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockBox extends Mock implements Box {}

void main(){
  MockBox mockBox;
  SessionBox sessionBox;
  SessionLocalDataSource sessionLocalDataSource;
  SessionModel model;
  setUp((){
    mockBox = MockBox();
    sessionBox = SessionBox(box: mockBox);
    sessionLocalDataSource = SessionLocalDataSourceImpl(sessionBox: sessionBox);

    model = SessionModel.fromJson(json.decode(convertJsonToString('session.json')));
  });

  group('cacheSession', () {

    test(
        'Should call the box put method to cache the current session with the session key',
            () async {
          await sessionLocalDataSource.cacheSession(model);

          verify(mockBox.put('session', model));
        }
    );
  });

  group('deleteSession', () {

    test(
        'Should call the box delete method to delete the current session with the session key',
            () async {
          await sessionLocalDataSource.deleteCachedSession();

          verify(mockBox.delete('session'));
        }
    );
  });

  group('getCachedSession', () {

    test(
        'Should call the box get method to retrieve the current session with the session key',
            () async {
          await sessionLocalDataSource.getCachedSession();

          verify(mockBox.get('session'));
        }
    );

    test(
        'Should retrieve the current session with the session key',
            () async {
          when(mockBox.get(any)).thenAnswer((_) => model);
          final result = await sessionLocalDataSource.getCachedSession();

          expect(result, model);
        }
    );

    test(
        'Should throw a SessionDoesNotExistException when there is no cached session',
            () async {
          when(mockBox.get(any)).thenThrow(SessionDoesNotExistException());

          final call = sessionLocalDataSource.getCachedSession;

          expect(() => call(), throwsA(TypeMatcher<SessionDoesNotExistException>()));
        }
    );
  });
}