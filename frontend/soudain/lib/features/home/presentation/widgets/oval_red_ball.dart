import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';

class OvalRedBall extends StatelessWidget {
  final IconData icon;
  final double clipOvalPadding;

  OvalRedBall({this.icon, this.clipOvalPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(clipOvalPadding),
      child: ClipOval(
        child: Container(
          color: primaryColor,
          child: icon != null ? AddButton() : Container(),
        ),
      ),
    );
  }

  Widget AddButton() {
    return Center(
      child: Icon(
        this.icon,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
