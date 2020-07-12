import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/injection_container.dart';

class OvalRedBall extends StatelessWidget {
  bool isAddButton;

  OvalRedBall({this.isAddButton = false});

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