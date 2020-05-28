import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'file:///C:/Users/mathe/OneDrive/Documentos/GitHub/SoudainCards/frontend/soudain/lib/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';
void main() {
  UserModel userModel;
  SessionModel sessionModel;
  setUp((){
    userModel = UserModel(
      id: 1,
      email: "email",
      name: "name"
    );
    sessionModel = SessionModel(
      token: "token",
      userModel: userModel
    );
  });

  test(
    'should convert JSON data to SessionModel by fromJson method',
    () {
      final Map<String,dynamic> jsonMap = json.decode(convertJsonToString('session.json'));

      final result = SessionModel.fromJson(jsonMap);

      expect(result, sessionModel);
    }
  );
}