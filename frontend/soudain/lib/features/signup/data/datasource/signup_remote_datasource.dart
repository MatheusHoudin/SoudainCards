import 'package:dio/dio.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/field_error.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';

abstract class SignUpRemoteDataSource {
  Future<UserModel> signUp({String name, String email, String password, String passwordConfirmation});
  Future<UserModel> signUpWithFacebook();
  Future<UserModel> signUpWithGoogle();
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  final Dio dio;

  SignUpRemoteDataSourceImpl({this.dio});

  @override
  Future<UserModel> signUp({String name, String email, String password, String passwordConfirmation}) async {
    try {
      final result = await dio.post('users', data: {
        "name": name,
        "email": email,
        "password": password,
        "passwordConfirmation": passwordConfirmation
      });

      return  UserModel.fromJson(result.data['data']);
    } on DioError catch(e) {
      if(e.response.statusCode == 401) {
        throw EmailAlreadyRegisteredException();
      }else if(e.response.statusCode == 400) {
        throw SessionRequestMalformedException(
            parameterErrorList: (e.response.data['error'] as List).map((e) => FieldError.fromJson(e)).toList()
        );
      }else if(e.response.statusCode == 500) {
        throw ServerException();
      }
    }
  }

  @override
  Future<UserModel> signUpWithFacebook() {
    // TODO: implement signUpWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithGoogle() {
    // TODO: implement signUpWithGoogle
    throw UnimplementedError();
  }

}