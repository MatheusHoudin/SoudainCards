import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soudain/core/hive/keys.dart';
import 'package:soudain/core/hive/session_box.dart';
import 'package:soudain/features/home/presentation/pages/home_page.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/features/login/presentation/pages/login_page.dart';
import 'package:soudain/features/main_page_view/presentation/pages/main_page_view.dart';
import 'package:soudain/features/play/presentation/bloc/collection_data_bloc.dart';
import 'package:soudain/injection_container.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainPageView();
  }

}
