import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRichText extends StatelessWidget {
  final String mainText;
  final String featuredText;
  final Function onTap;
  final double textSize;

  CustomRichText({
    this.mainText,
    this.featuredText,
    this.onTap,
    this.textSize
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.onTap(),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: this.mainText,
          style: GoogleFonts.comfortaa(
            textStyle: TextStyle(
              color: Colors.black,
                fontSize: textSize
              )
            ),
            children: <TextSpan>[
              TextSpan(
                text: '\n${this.featuredText}',
                style: GoogleFonts.comfortaa(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: textSize,
                    fontWeight: FontWeight.bold
                  )
                )
              )
            ]
        ),
      ),
    );
  }
}