import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/injection_container.dart';

class OvalRedBall extends StatelessWidget {
  final IconData icon;

  OvalRedBall({this.icon});

  @override
  Widget build(BuildContext context) {
    double clipOvalPadding = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 8,
        mediumPorcentage: 8,
        largePorcentage: 7
      ),
    );
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