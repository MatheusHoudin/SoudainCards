import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/login/presentation/pages/login_page.dart';
import 'injection_container.dart' as sl;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soudain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}