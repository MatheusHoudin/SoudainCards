import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soudain/features/login/presentation/bloc/session_bloc.dart';
import 'package:soudain/features/login/presentation/pages/login_page.dart';
import 'package:soudain/injection_container.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }

}