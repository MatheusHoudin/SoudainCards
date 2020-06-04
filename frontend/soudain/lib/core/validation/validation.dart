import 'package:email_validator/email_validator.dart';

bool validateEmail(String email) {
  if(email==null || email=='') return false;
  return EmailValidator.validate(email);
}

bool validatePassword(String password) {
  if(password==null || password=='') return false;
  return password.length >= 6;
}

bool validateName(String name) {
  if(name == null || name=='') return false;
  return true;
}

bool comparePasswords(String password, String passwordConfirmation) {
  return password == passwordConfirmation;
}