import 'package:hive/hive.dart';
import 'package:soudain/core/hive/keys.dart';
import 'package:soudain/features/home/data/model/user_data_model.dart';

class UserDataBox {
  final Box box;

  UserDataBox({
    this.box
  });

  UserDataModel getUserDataModel() {
    return box.get(session);
  }

  Future<void> cacheUserDataModel(UserDataModel model) {
    return box.put(userData,model);
  }
}