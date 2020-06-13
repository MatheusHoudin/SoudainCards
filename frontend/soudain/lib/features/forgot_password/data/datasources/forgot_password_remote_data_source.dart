import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/field_error.dart';
import 'package:soudain/features/forgot_password/data/model/forgot_password_confirmation_model.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<ForgotPasswordConfirmationModel> requestPasswordReset(String email);
}

class ForgotPasswordRemoteDataSourceImpl extends ForgotPasswordRemoteDataSource {
  final Dio dio;

  ForgotPasswordRemoteDataSourceImpl({this.dio});

  @override
  Future<ForgotPasswordConfirmationModel> requestPasswordReset(String email) async {
    try {
      final response = await dio.post('passwordreset', data: {
        "email": email
      });

      return ForgotPasswordConfirmationModel.fromJson(response.data['data']);
    } on DioError catch(e) {
      print(e.response);
      if (e.response != null) {
        if (e.response.statusCode == 404) {
          throw EmailNotRegisteredException();
        }else if(e.response.statusCode == 400) {
          throw PasswordResetRequestMalformedException(
              parameterErrorList: (e.response.data['error'] as List)
                  .map((e) => FieldError.fromJson(e))
                  .toList());
        }else{
          throw ServerException();
        }
      }else{
        throw ServerException();
      }
    }
  }

}