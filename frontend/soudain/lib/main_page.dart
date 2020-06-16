import 'package:flutter/material.dart';
import 'package:soudain/core/hive/keys.dart';
import 'package:soudain/core/hive/session_box.dart';
import 'package:soudain/features/home/presentation/pages/home.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/presentation/pages/login_page.dart';
import 'package:soudain/injection_container.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SessionModel sessionModel = sl<SessionBox>().box.get(session);

    return sessionModel == null ? LoginPage() : Home();
  }

}