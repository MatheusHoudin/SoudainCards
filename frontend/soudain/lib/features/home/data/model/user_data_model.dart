import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType()
class UserDataModel extends Equatable{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String avatar;

  UserDataModel({
    this.name,
    this.email,
    this.avatar
  });

  factory UserDataModel.fromJson(Map<String,dynamic> jsonMap) {
    return UserDataModel(
      name: jsonMap['name'],
      email: jsonMap['email'],
      avatar: jsonMap['avatar']['url'],
    );
  }

  @override
  List<Object> get props => [this.name,this.email,this.avatar];
}
