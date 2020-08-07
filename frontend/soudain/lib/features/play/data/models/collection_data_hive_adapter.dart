import 'package:hive/hive.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';

class CollectionDataAdapter extends TypeAdapter<CollectionData> {
  @override
  int get typeId => 4;

  @override
  CollectionData read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    Map<int,dynamic> fields = {};
    for(var i = 0; i < numOfFields; i++) {
      fields.putIfAbsent(reader.readByte(), () => reader.read());
    }
    return CollectionData(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      shared: fields[3] as bool,
      creator: fields[4] as int,
      decksCount: fields[5] as int,
      imageUrl: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CollectionData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.shared)
      ..writeByte(4)
      ..write(obj.creator)
      ..writeByte(5)
      ..write(obj.decksCount)
      ..writeByte(6)
      ..write(obj.imageUrl);
  }
}
