
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/deck_format.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/core/utils.dart';
import 'package:soudain/injection_container.dart';

class DeckCollection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double collectionPictureMarginTop = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 3,
        mediumPorcentage: 3,
        largePorcentage: 3
      )
    );
    double collectionPictureSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 4,
        mediumPorcentage: 5,
        largePorcentage: 5
      )
    );
    double frontPadding = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 4,
        mediumPorcentage: 6,
        largePorcentage: 6
      )
    );
    double collectionDeckNumberWidth = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 4,
        mediumPorcentage: 7,
        largePorcentage: 5.5
      )
    );
    double titleTextSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 4.8,
        mediumPorcentage: 4.8,
        largePorcentage: 5.5
      )
    );
    double descriptionTextSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 3.8,
        mediumPorcentage: 3.2,
        largePorcentage: 5.5
      )
    );
    return Stack(
      children: [
        Back(collectionPictureMarginTop,collectionPictureSize),
        Front(context,frontPadding,collectionDeckNumberWidth,titleTextSize,descriptionTextSize),
      ],
    );
  }

  Widget Front(BuildContext context,double frontPadding,double collectionDeckNumberWidth,double titleTextSize,double descriptionTextSize) {
    return Container(
      margin: EdgeInsets.only(
        right: 4,
        bottom: 4
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/folder_front_side.png',
          )
        )
      ),
      child: Padding(
        padding: EdgeInsets.only(top: frontPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: collectionDeckNumberWidth,
                height: MediaQuery.of(context).size.height * 0.05,
                padding: EdgeInsets.only(right: 4),
                child: DeckFormat(
                  isLeftMargin: true,
                  cardColor: positiveButtonColor,
                  secondaryColor: positiveButtonColor,
                  onPressed: () => null,
                  cardBorderRadius: 4,
                  cardsMargin: 4,
                  centerWidget: Text(
                    shortenNumberToString('4445'),
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 6,
                left: 6,
                bottom: 4
              ),
              child: Text(
                'French Voca ddfdsfdsb',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.comfortaa(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: titleTextSize
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 6,
                right: 6,
              ),
              child: Text(
                'A collection of decks with image and audio',
                maxLines: MediaQuery.of(context).size.height * 0.25 >= 200 ? 3 : 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.comfortaa(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: descriptionTextSize
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Back(double collectionPictureMarginTop, double collectionPictureSize) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/folder_back.png')
        )
      ),
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: 6,
          top: collectionPictureMarginTop
        ),
        height: collectionPictureSize,
        width: collectionPictureSize,
        child: Image.network(
          'https://www.worldflagshop.com/wp-content/uploads/2017/10/france-500x335.gif'
        ),
      ),
    );
  }
}