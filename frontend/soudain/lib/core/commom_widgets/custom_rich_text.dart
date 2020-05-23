import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRichText extends StatelessWidget {
  final String mainText;
  final String featuredText;
  final Function onTap;

  CustomRichText({
    this.mainText,
    this.featuredText,
    this.onTap
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
                fontSize: 18
              )
            ),
            children: <TextSpan>[
              TextSpan(
                text: this.featuredText,
                style: GoogleFonts.comfortaa(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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