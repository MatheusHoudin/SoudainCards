import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/constants/colors.dart';

class StudyDeckFront extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: DecksQuantitySection(),
                ),
                Expanded(
                  flex: 7,
                  child: DeckImage(),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: StudyProgress(context),
        ),
        Expanded(
          flex: 3,
          child: DeckTitle(),
        )
      ],
    );
  }

  Widget DecksQuantitySection(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DecksQuantity('5',lightYellow),
        ),
        Expanded(
          child: DecksQuantity('100',lightBlue),
        ),
        Expanded(
          child: DecksQuantity('50',lightRed),
        ),
      ],
    );
  }

  Widget DecksQuantity(String quantity, Color color) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Card(
        color: color,
        child: Container(
          child: Center(
            child: Text(
              quantity,
              style: TextStyle(
                color: Colors.black,
              ),
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
        Container(color: Colors.grey,),
        Container(
          width: (MediaQuery.of(context).size.width * 0.2) - 20,
          decoration: BoxDecoration(
            color: strongGreen,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            )
          ),
        )
      ],
    );
  }

  Widget DeckTitle(){
    return Container(
      child: Center(
        child: Text(
          'Chinese',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.comfortaa(
            color: Colors.black,
            fontSize: 18
          ),
        ),
      ),
    );
  }
}