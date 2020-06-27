import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/hive/keys.dart';
import 'package:soudain/core/hive/user_data_box.dart';
import 'package:soudain/features/home/data/model/user_data_model.dart';

abstract class UserDataLocalDataSource {
  Future<UserDataModel> getCachedUserData();
  Future<int> cacheUserData(UserDataModel userDataModel);
}

class UserDataLocalDataSourceImpl extends UserDataLocalDataSource {
  final UserDataBox userDataBox;

  UserDataLocalDataSourceImpl({this.userDataBox});

  @override
  Future<int> cacheUserData(UserDataModel userDataModel) {
    return userDataBox.box.put(userData, userDataModel);
  }

  @override
  Future<UserDataModel> getCachedUserData() {
    final userDataModel = userDataBox.box.get(userData);
    if(userDataModel!=null) {
      return Future.value();
    }else {
      throw UserDataDoesNotExistException();
    }
  }

}