import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/constants/api.dart';
import 'package:soudain/core/hive/session_box.dart';
import 'package:soudain/features/home/data/datasource/user_data_remote_data_source.dart';
import 'package:soudain/features/home/data/model/user_data_model.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}
class MockSessionBox extends Mock implements SessionBox {}

void main() {
  MockDio mockDio;
  UserDataRemoteDataSource dataSource;
  MockSessionBox mockSessionBox;
  SessionModel sessionModel;
  UserDataModel userDataModel;

  setUp((){
    sessionModel = SessionModel.fromJson(json.decode(convertJsonToString('session.json')));
    userDataModel = UserDataModel.fromJson(json.decode(convertJsonToString('user_data.json')));
    mockSessionBox = MockSessionBox();
    mockDio = MockDio();
    dataSource = UserDataRemoteDataSourceImpl(
      dio: mockDio,
      sessionBox: mockSessionBox
    );
  });



  test(
    'Should return the UserDataModel with the data from the api',
    () async {
      when(mockSessionBox.getSessionModel()).thenReturn(sessionModel);
      when(mockDio.get(any)).thenAnswer((_) async => Response(
          statusCode: 200,
          data: {
            "code": 200,
            "data": {
              "id": 1,
              "name": 'name',
              "email": 'email',
              "avatar_id": 1,
              "avatar": {
                "url": 'avatar',
                "path": 'path'
              }
            },
            "message": "message"
          }
      ));
      final result = await dataSource.getUserData(1);

      expect(userDataModel, result);
    }
  );
}