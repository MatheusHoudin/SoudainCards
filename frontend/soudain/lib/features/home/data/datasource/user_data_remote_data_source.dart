import 'package:dio/dio.dart';
import 'package:soudain/core/dio/custom_dio_options.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/field_error.dart';
import 'package:soudain/core/hive/session_box.dart';
import 'package:soudain/features/home/data/model/user_data_model.dart';

abstract class UserDataRemoteDataSource {
  Future<UserDataModel> getUserData(int id);
}

class UserDataRemoteDataSourceImpl extends UserDataRemoteDataSource {
  final Dio dio;
  final SessionBox sessionBox;

  UserDataRemoteDataSourceImpl({this.dio, this.sessionBox});

  @override
  Future<UserDataModel> getUserData(int id) async {
    try {
      final response = await dio.get('users/$id',
          options: CustomDioOptions(
              headers: {'Authorization': sessionBox.getSessionModel().getToken}));

      final UserDataModel model = UserDataModel.fromJson(response.data['data']);
      return model;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response.statusCode == 404) {
          throw UserDataDoesNotExistException();
        } else if (e.response.statusCode == 400) {
          print(e.response.data);
          throw SignUpRequestMalformedException(
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
}
