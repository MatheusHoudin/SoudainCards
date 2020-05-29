import 'package:email_validator/email_validator.dart';

bool validateEmail(String email) {
  if(email==null) return false;
  return EmailValidator.validate(email);
}

bool validatePassword(String password) {
  if(password==null) return false;
  return password.length >= 6;
}