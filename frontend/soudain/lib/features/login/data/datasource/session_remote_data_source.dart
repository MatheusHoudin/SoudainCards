import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/field_error.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';

abstract class SessionRemoteDataSource {
  Future<SessionModel> createSession({String email, String password});
  Future<SessionModel> createFacebookSession();
  Future<SessionModel> createGoogleSession();
}

class SessionRemoteDataSourceImpl extends SessionRemoteDataSource {
  final Dio dio;
  final FacebookLogin facebookLogin;

  SessionRemoteDataSourceImpl({
    this.dio,
    this.facebookLogin
  });

  @override
  Future<SessionModel> createSession({String email, String password}) async {
    try {
      final response = await dio
          .post('sessions', data: {'email': email, 'password': password});

      if (response.statusCode == 201) {
        return SessionModel.fromJson(response.data['data']);
      } else if (response.statusCode == 500) {
        throw ServerException();
      }
    } on DioError catch (e) {
      print('response');
      print(e.response);
      if (e.response != null) {
        if (e.response.statusCode == 401) {
          if (e.response.data['data']['email'] != null) {
            throw EmailNotRegisteredException();
          } else if (e.response.data['data']['password'] != null) {
            throw PasswordDoesNotMatchException();
          }
        } else if (e.response.statusCode == 400) {
          throw SessionRequestMalformedException(
              parameterErrorList: (e.response.data['error'] as List)
                  .map((e) => FieldError.fromJson(e))
                  .toList());
        } else if (e.response.statusCode == 500) {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<SessionModel> createFacebookSession() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          final token = result.accessToken.token;
          final facebookResponse = await dio.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(800).height(800)&access_token=$token');

          final Map<String, dynamic> jsonMap = json.decode(facebookResponse.data);
          final response = await dio.post('sessions/thirdpart', data: {
            'id': jsonMap['id'],
            'email': jsonMap['email'],
            'name': jsonMap['name'],
            'picture': jsonMap['picture']['data']['url'],
            'isFacebook': true
          });

          return SessionModel.fromJson(response.data['data']);
        } on DioError catch (e) {
          if (e.response != null) {
            if (e.response.statusCode == 400) {
              throw SessionRequestMalformedException(
                  parameterErrorList: (e.response.data['error'] as List)
                      .map((e) => FieldError.fromJson(e))
                      .toList());
            } else if (e.response.statusCode == 500) {
              throw ServerException();
            }
          } else {
            throw ServerException();
          }
        } on Exception {
          throw ServerException();
        }

        break;
      case FacebookLoginStatus.error:
        throw ServerException();
      case FacebookLoginStatus.cancelledByUser:
        throw FacebookLoginCancelledByUserException();
        break;
    }
  }

  @override
  Future<SessionModel> createGoogleSession() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'profile',
        'https://www.googleapis.com/auth/userinfo.profile'
      ],
    );

    GoogleSignInAccount account = await googleSignIn.signIn();
    if(account != null) {
      try {
        final resizedProfileImageUrl = account.photoUrl.replaceFirst('s96-c', 's800-c');
        final response = await dio.post('sessions/thirdpart', data: {
          'id': account.id,
          'email': account.email,
          'name': account.displayName,
          'picture': resizedProfileImageUrl,
          'isFacebook': false
        });

        return SessionModel.fromJson(response.data['data']);
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response.statusCode == 400) {
            throw SessionRequestMalformedException(
                parameterErrorList: (e.response.data['error'] as List)
                    .map((e) => FieldError.fromJson(e))
                    .toList());
          } else if (e.response.statusCode == 500) {
            throw ServerException();
          }
        } else {
          throw ServerException();
        }
      } on Exception {
        throw ServerException();
      }
    }else{
      throw GoogleLoginCancelledByUserException();
    }
  }
}
