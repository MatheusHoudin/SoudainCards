import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/constants/api.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';
import 'package:soudain/features/signup/data/datasource/signup_remote_datasource.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  MockDio mockDio;
  SignUpRemoteDataSource dataSource;
  UserModel userModel;

  dynamic request = {
    "name": 'name',
    "email": 'email',
    "password": 'password',
    "passwordConfirmation": 'password'
  };

  setUp((){
    userModel = UserModel.fromJson(json.decode(convertJsonToString('user.json')));
    mockDio = MockDio();
    mockDio.options = BaseOptions(
        baseUrl: apiBaseUrl
    );
    dataSource = SignUpRemoteDataSourceImpl(dio: mockDio);
  });

  group('signUp',() {

    test(
      'Should call the right endpoint',
      () async {
        when(mockDio.post(any, data: request))
            .thenAnswer((_) async => Response(
            statusCode: 201,
            data: {
              "code": 201,
              "data": json.decode(convertJsonToString('user.json')),
              "message": "message"
            }
        ));
        await dataSource.signUp(name: 'name', email: 'email', password: 'password', passwordConfirmation: 'password');
        
        verify(mockDio.post('users', data: {
          "name": 'name',
          "email": 'email',
          "password": 'password',
          "passwordConfirmation": 'password'
        }));
      }
    );

    test(
      'Should return UserModel when call to signup endpoint is successfull',
      () async {
        when(mockDio.post(any, data: request))
            .thenAnswer((_) async => Response(
              statusCode: 201,
              data: {
                "code": 201,
                "data": json.decode(convertJsonToString('user.json')),
                "message": "message"
              }
        ));

        final result = await dataSource.signUp(name: 'name', email: 'email', password: 'password', passwordConfirmation: 'password');

        expect(result, userModel);
      }
    );
  });
}