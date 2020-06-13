import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:soudain/features/forgot_password/data/model/forgot_password_confirmation_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  ForgotPasswordConfirmationModel passwordConfirmation;

  setUp((){
    passwordConfirmation = ForgotPasswordConfirmationModel(
      code: 'code',
      expireDate: '2020-06-15T23:00:21.287Z'
    );
  });

  test(
    'Should return a ForgotPasswordConfirmation object with the json data when fromJson is called',
    () async {
      final result = ForgotPasswordConfirmationModel.fromJson(json.decode(convertJsonToString('forgot_password_confirmation.json')));

      expect(result, passwordConfirmation);
    }
  );
}