import 'dart:io';

String convertJsonToString(String fileName) => File('test/fixtures/$fileName').readAsStringSync();