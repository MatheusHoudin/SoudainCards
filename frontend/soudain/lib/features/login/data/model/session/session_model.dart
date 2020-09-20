import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';

@HiveType()
class SessionModel extends Equatable{
  @HiveField(0)
  final UserModel userModel;
  @HiveField(1)
  final String token;

  SessionModel({
    this.userModel,
    this.token
  });

  String get getToken => token;

  factory SessionModel.fromJson(Map<String, dynamic> jsonMap) {
    print(jsonMap);
    return SessionModel(
      token: jsonMap['token'],
      userModel: UserModel.fromJson(jsonMap['user'])
    );
  }

  @override
  List<Object> get props => [token,userModel];
}
