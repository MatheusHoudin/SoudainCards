import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LogoCard(0,0,false),
        LogoCard(10,10,false),
        LogoCard(20,10,true)
      ],
    );
  }

  Widget LogoCard(double leftMargin,double elevation, bool showCenterWidget) {
    return Card(
      margin: EdgeInsets.only(left: leftMargin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      color: Colors.white,
      elevation: elevation,
      shadowColor: Colors.grey,
      child: Center(
        child: showCenterWidget ? CenterWidget() : Container(),
      ),
    );
  }
  
  Widget CenterWidget() {
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