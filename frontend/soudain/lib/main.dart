import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/login/presentation/pages/login_page.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/main_page.dart';
import 'injection_container.dart' as sl;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(navigatorKey: _navigatorKey),
      child: OKToast(
        child: MaterialApp(
          title: 'Soudain',
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: primaryColor,
            primarySwatch: Colors.blue,
          ),
          home: MainPage(),
        ),
      ),
    );
  }
}