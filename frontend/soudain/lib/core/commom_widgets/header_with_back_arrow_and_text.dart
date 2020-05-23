import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWithBackArrowAndText extends StatelessWidget {
  final String headerText;
  final double textSize;

  HeaderWithBackArrowAndText({
    this.headerText,
    this.textSize
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          Text(
            headerText,
            textAlign: TextAlign.center,
            style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: textSize
                )
            ),
          )
        ],
      ),
    );
  }
}