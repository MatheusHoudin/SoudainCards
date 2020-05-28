import 'package:hive/hive.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';

class SessionModelAdapter extends TypeAdapter<SessionModel> {
  @override
  int get typeId => 2;

  @override
  SessionModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    Map<int,dynamic> fields = {};
    for(var i = 0; i < numOfFields; i++) {
      fields.putIfAbsent(reader.readByte(), () => reader.read());
    }
    return SessionModel(
      userModel: fields[0] as UserModel,
      token: fields[1] as String
    );
  }

  @override
  void write(BinaryWriter writer, SessionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userModel)
      ..writeByte(1)
      ..write(obj.token);
  }
}
