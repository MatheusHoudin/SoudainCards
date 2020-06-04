
import 'package:dio/dio.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/field_error.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';

abstract class SessionRemoteDataSource {
  Future<SessionModel> createSession({String email, String password});
}

class SessionRemoteDataSourceImpl extends SessionRemoteDataSource {
  final Dio dio;

  SessionRemoteDataSourceImpl({
    this.dio
  });

  @override
  Future<SessionModel> createSession({String email, String password}) async {
    try {
      final response = await dio.post('sessions', data: {
        'email': email,
        'password': password
      });

      if (response.statusCode == 201) {

        return SessionModel.fromJson(response.data['data']);
      }else if(response.statusCode == 500) {
        throw ServerException();
      }
    } on DioError catch(e) {
      print('response');
      print(e.response);
      if(e.response != null) {
        if(e.response.statusCode == 401){

          if(e.response.data['data']['email'] != null) {

            throw EmailNotRegisteredException();
          }else if(e.response.data['data']['password'] != null){

            throw PasswordDoesNotMatchException();
          }
        }else if(e.response.statusCode == 400){
          throw SessionRequestMalformedException(
              parameterErrorList: (e.response.data['error'] as List).map((e) => FieldError.fromJson(e)).toList()
          );
        }else if(e.response.statusCode == 500){
          throw ServerException();
        }
      }else{
        throw ServerException();
      }

    }
  }
}

