import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class UserModel extends Equatable{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;

  UserModel({
    this.email,
    this.name,
    this.id
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonMap) {
    return UserModel(
      id: jsonMap['id'],
      name: jsonMap['name'],
      email: jsonMap['email']
    );
  }

  @override
  List<Object> get props => [id, name, email];
}