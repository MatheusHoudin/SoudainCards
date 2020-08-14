import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/core/utils.dart';
import 'package:soudain/injection_container.dart';

class StudyDeckFront extends StatelessWidget {
  final bool hasDecksToStudy;

  StudyDeckFront({this.hasDecksToStudy = true});

  @override
  Widget build(BuildContext context) {
    double quantityTextSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 3.5,
        mediumPorcentage: 3.5,
        largePorcentage: 30)
    );
    return Column(
      children: [
        Expanded(
          flex: this.hasDecksToStudy ? 7 : 8,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: this.hasDecksToStudy ? DecksQuantitySection(quantityTextSize) : DeckContentDetailsSection(quantityTextSize),
                ),
                Expanded(
                  flex: this.hasDecksToStudy ? 6 : 8,
                  child: DeckImage(),
                )
              ],
            ),
          ),
        ),
        this.hasDecksToStudy ? Expanded(
          flex: 1,
          child: StudyProgress(context),
        ) : Container(),
        Expanded(
          flex: 4,
          child: DeckTitle(),
        )
      ],
    );
  }

  Widget DeckContentDetailsSection(double quantityTextSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: DeckDetail(Icons.play_circle_filled, '734', quantityTextSize),
        ),
        Expanded(
          child: DeckDetail(Icons.image, '7344', quantityTextSize),
        ),
        Expanded(
          child: DeckDetail(Icons.library_books, '7344', quantityTextSize),
        ),
      ],
    );
  }

  Widget DeckDetail(IconData iconData, String quantity, double quantityTextSize) {
    String formattedQuantity = shortenNumberToString(quantity);
    return Column(
      children: <Widget>[
        Icon(
          iconData,
          color: secondaryColor,
        ),
        Text(
          formattedQuantity,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: TextStyle(color: Colors.black, fontSize: quantityTextSize),
        )
      ],
    );
  }

  Widget DecksQuantitySection(double quantityTextSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DecksQuantity('5', lightYellow, quantityTextSize),
        ),
        Expanded(
          child: DecksQuantity('2275545', lightBlue, quantityTextSize),
        ),
        Expanded(
          child: DecksQuantity('50', lightRed, quantityTextSize),
        ),
      ],
    );
  }

  Widget DecksQuantity(String quantity, Color color, double quantityTextSize) {
    String formattedQuantity = shortenNumberToString(quantity);
    return Padding(
      padding: EdgeInsets.all(2),
      child: Card(
        color: color,
        child: Container(
          child: Center(
            child: Text(
              formattedQuantity,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(color: Colors.black, fontSize: quantityTextSize),
            ),
          ),
        ),
      ),
    );
  }

  Widget DeckImage() {
    return Padding(
      padding: EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/1200px-Flag_of_the_People%27s_Republic_of_China.svg.png',
        ),
      ),
    );
  }

  Widget StudyProgress(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.grey,
        ),
        Container(
          width: (MediaQuery.of(context).size.width * 0.26),
          decoration: BoxDecoration(
              color: strongGreen,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              )),
        )
      ],
    );
  }

  Widget DeckTitle() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6
      ),
      child: Center(
        child: Text(
          'Chinese culture and id',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.comfortaa(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
