import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';

class OvalRedBall extends StatelessWidget {
  bool isAddButton;

  OvalRedBall({this.isAddButton = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: ClipOval(
        child: Container(
          color: primaryColor,
          child: isAddButton ? AddButton() : Container(),
        ),
      ),
    );
  }

  Widget AddButton() {
    return Center(
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
    );
  }

}