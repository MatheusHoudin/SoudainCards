import 'package:email_validator/email_validator.dart';

bool validateEmail(String email) {
  if(email==null || email=='') return false;
  print('EMAIL');
  print(email);
  print('result: ${EmailValidator.validate(email)}');
  return EmailValidator.validate(email);
}

bool validatePassword(String password) {
  if(password==null || password=='') return false;
  return password.length >= 6;
}