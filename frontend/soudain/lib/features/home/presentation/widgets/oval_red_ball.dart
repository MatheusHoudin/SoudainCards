import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';

class OvalRedBall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: ClipOval(
        child: Container(
          color: primaryColor,
        ),
      ),
    );
  }

}