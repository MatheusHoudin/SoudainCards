import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:soudain/features/login/data/model/user/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';
void main() {
  final UserModel userModel = UserModel(
    id: 1,
    name: "name",
    email: "email"
  );

  test(
    'hould convert JSON data to UserModel by fromJson methods',
    () {
      final Map<String, dynamic> jsonMap = json.decode(convertJsonToString('user.json'));

      final UserModel result = UserModel.fromJson(jsonMap);

      expect(result, userModel);
    }
  );
}