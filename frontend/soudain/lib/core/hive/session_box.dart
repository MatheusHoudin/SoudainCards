import 'package:hive/hive.dart';
import 'package:soudain/core/hive/keys.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';

class SessionBox {
  final Box box;

  SessionBox({
    this.box
  });

  SessionModel getSessionModel() {
    return box.get(session);
  }
}