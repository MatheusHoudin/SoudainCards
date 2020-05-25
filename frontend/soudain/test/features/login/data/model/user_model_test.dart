import 'dart:convert';

import 'file:///C:/Users/mathe/OneDrive/Documentos/GitHub/SoudainCards/frontend/soudain/lib/features/login/data/model/user/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';
void main() {
  final UserModel userModel = UserModel(
    id: 1,
    name: "name",
    email: "email"
  );

  test(
    'should convert JSON data to UserModel by fromJson method',
    () {
      final Map<String, dynamic> jsonMap = json.decode(convertJsonToString('user.json'));

      final UserModel result = UserModel.fromJson(jsonMap);

      expect(result, userModel);
    }
  );
}