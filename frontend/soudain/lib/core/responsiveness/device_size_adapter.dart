import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

const double smallDeviceBreakpoint = 400.0;
const double mediumDeviceBreakpoint = 600.0;

class DeviceSizeAdapter {

  double getResponsiveSize({
    BuildContext context,
    SizeAdapter landscapeSizeAdapter,
    SizeAdapter portraitSizeAdapter
  }){
    final SizeAdapter choosenSizeAdatper = MediaQuery.of(context).orientation == Orientation.landscape
        ?
    landscapeSizeAdapter
        :
    portraitSizeAdapter;

    double screenSize = choosenSizeAdatper.isHeight
        ?
    MediaQuery.of(context).size.height
        :
    MediaQuery.of(context).size.width;

    double porcentage;

    if (screenSize <= smallDeviceBreakpoint) {
      porcentage = choosenSizeAdatper.smallPorcentage;
    } else if(screenSize > smallDeviceBreakpoint && screenSize <= mediumDeviceBreakpoint) {
      porcentage = choosenSizeAdatper.mediumPorcentage;
    }else{
      porcentage = choosenSizeAdatper.largePorcentage;
    }

    return (screenSize * porcentage) / 100;
  }
}

class SizeAdapter {
  final bool isHeight;
  final double smallPorcentage;
  final double mediumPorcentage;
  final double largePorcentage;

  SizeAdapter({
    @required this.smallPorcentage,
    @required this.mediumPorcentage,
    @required this.largePorcentage,
    @required this.isHeight
  });
}