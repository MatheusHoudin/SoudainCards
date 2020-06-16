import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/hive/keys.dart';
import 'package:soudain/core/hive/session_box.dart';
import 'package:soudain/features/home/presentation/widgets/header.dart';
import 'package:soudain/features/login/data/model/session/session_model.dart';
import 'package:soudain/injection_container.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Header(),
              ),
              Expanded(
                flex: 18,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}