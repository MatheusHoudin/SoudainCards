import 'package:flutter/material.dart';
import 'package:soudain/core/hive/keys.dart';
import 'package:soudain/core/hive/session_box.dart';
import 'package:soudain/features/home/presentation/pages/home.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/presentation/pages/login_page.dart';
import 'package:soudain/features/main_page_view/presentation/pages/main_page_view.dart';
import 'package:soudain/injection_container.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainPageView();
  }

}