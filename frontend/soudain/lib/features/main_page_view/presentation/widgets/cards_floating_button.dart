import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/injection_container.dart';

class CardsFloatingButton extends StatefulWidget {
  final IconData icon;
  final bool isDeckStackOpen;
  final Function onDeckTap;
  final Function nagivateToHomeFunction;
  final Function nagivateToPlayFunction;
  final Function nagivateToProgressFunction;

  CardsFloatingButton({
    this.icon,
    this.onDeckTap,
    this.nagivateToHomeFunction,
    this.nagivateToPlayFunction,
    this.nagivateToProgressFunction,
    this.isDeckStackOpen,
  });

  @override
  _CardsFloatingButtonState createState() => _CardsFloatingButtonState();
}

class _CardsFloatingButtonState extends State<CardsFloatingButton> {
  @override
  Widget build(BuildContext context) {
    double iconSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
          isHeight: false,
          smallPorcentage: 6.5,
          mediumPorcentage: 6,
          largePorcentage: 5),
    );
    double cardRightMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
          isHeight: false,
          smallPorcentage: 2,
          mediumPorcentage: 2,
          largePorcentage: 0),
    );

    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: DeckCard(
              0,
              8,
              iconSize,
              () => widget.isDeckStackOpen
                  ? widget.nagivateToProgressFunction()
                  : widget.onDeckTap(),
              Icons.show_chart),
        ),
        Align(
          alignment: Alignment.center,
          child: DeckCard(
              widget.isDeckStackOpen ? 0 : cardRightMargin,
              8,
              iconSize,
              () => widget.isDeckStackOpen
                  ? widget.nagivateToPlayFunction()
                  : widget.onDeckTap(),
              Icons.play_arrow),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: DeckCard(
              widget.isDeckStackOpen ? 0 : cardRightMargin * 2,
              8,
              iconSize,
              () => widget.isDeckStackOpen
                  ? widget.nagivateToHomeFunction()
                  : widget.onDeckTap(),
              widget.isDeckStackOpen ? Icons.home : widget.icon),
        ),
      ],
    );
  }

  Widget DeckCard(double margin, double elevation, double iconSize,
      Function onPressed, IconData icon) {
    return Card(
      margin: EdgeInsets.only(right: margin),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      color: primaryColor,
      elevation: elevation,
      child: RawMaterialButton(
          splashColor: Colors.white,
          onPressed: () => onPressed(),
          child: Container(
            width: 50,
            child: Center(
              child: Icon(
                icon,
                size: iconSize,
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
