import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/hive/keys.dart';
import 'package:soudain/core/hive/session_box.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';

abstract class SessionLocalDataSource {
  Future<void> cacheSession(SessionModel sessionModel);
  Future<SessionModel> getCachedSession();
  Future<void> deleteCachedSession();
}

class SessionLocalDataSourceImpl extends SessionLocalDataSource {
  final SessionBox sessionBox;

  SessionLocalDataSourceImpl({this.sessionBox});

  @override
  Future<void> cacheSession(SessionModel sessionModel) async {
    return await sessionBox.box.put(session, sessionModel);
  }

  @override
  Future<void> deleteCachedSession() async {
    return await sessionBox.box.delete(session);
  }

  @override
  Future<SessionModel> getCachedSession() {
    SessionModel cachedSession = sessionBox.box.get(session);
    if(cachedSession != null) {
      return Future.value(cachedSession);
    }else{
      throw SessionDoesNotExistException();
    }

  }

}