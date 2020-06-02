import 'package:dio/dio.dart';
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
    final result = await dio.post('users', data: {
      "name": name,
      "email": email,
      "password": password,
      "passwordConfirmation": passwordConfirmation
    });
    print(result);
    return  UserModel.fromJson(result.data['data']);
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