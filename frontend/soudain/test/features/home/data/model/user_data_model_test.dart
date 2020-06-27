import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:soudain/features/home/data/model/user_data_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  final userDataModel = UserDataModel(
    name: 'name',
    email: 'email',
    avatar: 'avatar'
  );
  
  test(
    'Should return a projer UserDataModel when fromJson is called',
    () async {
      final result = UserDataModel.fromJson(json.decode(convertJsonToString('user_data.json')));

      expect(result, userDataModel);
    }
  );
}