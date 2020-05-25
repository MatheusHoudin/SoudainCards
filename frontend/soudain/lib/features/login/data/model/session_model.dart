import 'file:///C:/Users/mathe/OneDrive/Documentos/GitHub/SoudainCards/frontend/soudain/lib/features/login/data/model/user/user_model.dart';

class SessionModel {
  final UserModel userModel;
  final String token;

  SessionModel({
    this.userModel,
    this.token
  });

  factory SessionModel.fromJson(Map<String, dynamic> jsonMap) {

  }
}