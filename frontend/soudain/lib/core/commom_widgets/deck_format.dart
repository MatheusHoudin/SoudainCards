import 'package:flutter/material.dart';

class DeckFormat extends StatelessWidget {
  final Widget centerWidget;
  final double cardsMargin;
  final double cardBorderRadius;
  final bool isLeftMargin;
  final Color cardColor;
  final Color secondaryColor;
  final Function onPressed;

  DeckFormat({
    this.centerWidget,
    this.cardsMargin,
    this.cardBorderRadius,
    this.isLeftMargin,
    this.cardColor,
    this.secondaryColor,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LogoCard(0,0,false,secondaryColor,null),
        LogoCard(cardsMargin,cardsMargin,false,secondaryColor,null),
        LogoCard(cardsMargin*2,cardsMargin,true,cardColor,onPressed)
      ],
    );
  }

  Widget LogoCard(double margin,double elevation, bool showCenterWidget,Color color, Function onPressed) {
    EdgeInsets cardMargin = this.isLeftMargin ? EdgeInsets.only(left: margin) : EdgeInsets.only(right: margin);
    return Card(
      margin: cardMargin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(this.cardBorderRadius))
      ),
      color: color,
      elevation: elevation,

      child: onPressed != null ? RawMaterialButton(
        splashColor: Colors.white,
        onPressed: () => onPressed,
        child: Center(
          child: showCenterWidget ? centerWidget : Container(),
        ),
      ) : Center(
        child: showCenterWidget ? centerWidget : Container(),
      ),
    );
  }
}