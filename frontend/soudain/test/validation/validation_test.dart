import 'package:flutter_test/flutter_test.dart';
import 'package:soudain/core/validation/validation.dart';

void main(){
  test(
    'Should return true on a valid email',
    () async {
      expect(validateEmail('matheusdin04@gmail.com'), true);
    }
  );

  test(
    'Should return false on an invalid email',
    () async {
      expect(validateEmail(null), false);
      expect(validateEmail(''), false);
      expect(validateEmail('a'), false);
      expect(validateEmail('a@'), false);
      expect(validateEmail('a@b'), false);
      expect(validateEmail('a@b.'), false);
    }
  );

  test(
    'Should return false on a less than 6 characters password',
    () async {
      expect(validatePassword(null), false);
      expect(validatePassword(''), false);
      expect(validatePassword('a'), false);
      expect(validatePassword('aa'), false);
      expect(validatePassword('aaa'), false);
      expect(validatePassword('aaaa'), false);
      expect(validatePassword('aaaaa'), false);
    }
  );

  test(
    'Should return true on a more or equals 6 characters password',
    () async {
      expect(validatePassword('aaaaaa'), true);
      expect(validatePassword('aaaaaaa'), true);
    }
  );
}