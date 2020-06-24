import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/injection_container.dart';

class CardsFloatingButton extends StatelessWidget {
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
    this.isDeckStackOpen
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 6.5,
        mediumPorcentage: 6,
        largePorcentage: 5
      ),
    );
    double cardRightMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 2,
        mediumPorcentage: 2,
        largePorcentage: 0
      ),
    );
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: DeckCard(0,8,iconSize,() => isDeckStackOpen ? nagivateToProgressFunction() : onDeckTap(),Icons.email),
        ),
        Align(
          alignment: Alignment.center,
          child: DeckCard(isDeckStackOpen ? 0 : cardRightMargin,8,iconSize,() => isDeckStackOpen ? nagivateToPlayFunction() : onDeckTap(),Icons.cast),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: DeckCard(isDeckStackOpen ? 0 : cardRightMargin*2,8,iconSize,() => isDeckStackOpen ? nagivateToHomeFunction() : onDeckTap(),Icons.home),
        ),
      ],
    );
  }

  Widget DeckCard(double margin,double elevation, double iconSize, Function onPressed, IconData icon) {
    return Card(
      margin: EdgeInsets.only(right: margin),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))
      ),
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
        )
      ),
    );
  }
}

/*
Logo(
      centerWidget: Icon(
        icon,
        color: Colors.white,
      ),
      cardBorderRadius: 4,
      cardsMargin: 8,
      isLeftMargin: false,
      cardColor: primaryColor,
      secondaryColor: Color(0xffB82D38),
      onPressed: () => null,
    );
 */