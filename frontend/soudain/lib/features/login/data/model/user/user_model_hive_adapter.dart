
import 'package:hive/hive.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  int get typeId => 1;

  @override
  UserModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    Map<int,dynamic> fields = {};
    for(var i = 0; i < numOfFields; i++) {
      fields.putIfAbsent(reader.readByte(), () => reader.read());
    }
    return UserModel(
      email: fields[2] as String,
      name: fields[1] as String,
      id: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email);
  }
}
