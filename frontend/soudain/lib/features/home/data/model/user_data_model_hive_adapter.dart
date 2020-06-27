import 'package:hive/hive.dart';
import 'package:soudain/features/home/data/model/user_data_model.dart';

class UserDataModelAdapter extends TypeAdapter<UserDataModel> {
  @override
  int get typeId => 3;

  @override
  UserDataModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    Map<int,dynamic> fields = {};
    for(var i = 0; i < numOfFields; i++) {
      fields.putIfAbsent(reader.readByte(), () => reader.read());
    }

    return UserDataModel(
      name: fields[0] as String,
      email: fields[1] as String,
      avatar: fields[2] as String,
    );

  }

  @override
  void write(BinaryWriter writer, UserDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.avatar);
  }
}
