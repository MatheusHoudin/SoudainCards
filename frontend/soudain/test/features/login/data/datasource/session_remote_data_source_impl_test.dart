
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:soudain/core/constants/api.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/features/login/data/datasource/session_remote_data_source.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class DioMock extends Mock implements Dio {}

void main(){
  DioMock dioMock;
  SessionRemoteDataSourceImpl dataSourceImpl;
  SessionModel sessionModel;

  dynamic request = {
    'email': 'email',
    'password': 'pass'
  };

  setUp((){
    dioMock = DioMock();
    dioMock.options = BaseOptions(
      baseUrl: apiBaseUrl
    );
    dataSourceImpl = SessionRemoteDataSourceImpl(
      dio: dioMock
    );

    sessionModel = SessionModel(
      token: 'token',
      userModel: UserModel.fromJson(json.decode(convertJsonToString('user.json')))
    );
  });

  setUpMockSuccess(){
    when(dioMock.post(any,data: request))
        .thenAnswer((_) async => Response(
        statusCode: 201,
        data: {
          "code": 201,
          "data": {
            "user": json.decode(convertJsonToString('user.json')),
            "token": "token"
          },
          "message": "message"
        }
    ));
  }
  
  test(
    'should call the right endpoint to create a session',
    () async {
      setUpMockSuccess();
      await dataSourceImpl.createSession(email: 'email', password: 'pass');
      
      verify(dioMock.post('sessions', data: request));
    }
  );

  test(
    'should send the email and password provided as parameters in order to create a session',
    () async {
      setUpMockSuccess();
      await dataSourceImpl.createSession(email: 'email', password: 'pass');

      verify(dioMock.post('sessions', data: {
        "email": 'email',
        "password": 'pass'
      }));
    }
  );

  test(
    'should return a SessionModel when creating a session is successfull',
    () async {
      setUpMockSuccess();

      final result = await dataSourceImpl.createSession(email: 'email', password: 'pass');

      expect(result, sessionModel);
    }
  );

  test(
    'should return a EmailNotRegisteredException when provided email does not exist',
    () async {
      when(dioMock.post(any, data: request))
      .thenAnswer((_) async => Response(
        statusCode: 401,
        data: {
          "code": 401,
          "data": {
            "email": "email"
          },
          "message": "message"
        }
      ));

      final call = dataSourceImpl.createSession;

      expect(() => call(
        email: 'email',
        password: 'pass'
      ), throwsA(TypeMatcher<EmailNotRegisteredException>()));
    }
  );

  test(
    'should return a PasswordDoesNotMatchException when provided password does not match with the provided email',
    () async {
      when(dioMock.post(any, data: request))
        .thenAnswer((_) async => Response(
        statusCode: 401,
        data: {
          "code": 401,
          "data": {
            "password": "pass"
          },
          "message": "message"
          }
      ));

        final call = () => dataSourceImpl.createSession(email: 'email', password: 'pass');

        expect(() => call(), throwsA(TypeMatcher<PasswordDoesNotMatchException>()));
      }
  );

  test(
    'should throw a ServerException when call to the api fails',
    () async {
      when(dioMock.post(any, data: request))
        .thenAnswer((_) async => Response(
        statusCode: 500,
        data: {
          "code": 500,
          "error": "error",
          "message": "error"
        }
      ));

      final call = dataSourceImpl.createSession;

      expect(() => call(
        email: 'email',
        password: 'pass'
      ), throwsA(TypeMatcher<ServerException>()));
    }
  );

  test(
    'should throw a SessionMalformedException when email or password is wrong',
    () async {
      when(dioMock.post(any, data: request))
        .thenAnswer((_) async => Response(
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
      ));

      final call = dataSourceImpl.createSession;

      expect(() => call(
        email: 'email',
        password: 'pass'
      ), throwsA(TypeMatcher<SessionRequestMalformedException>()));
    }
  );


}