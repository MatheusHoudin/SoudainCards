import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/constants/colors.dart';
class CommomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final double buttonTextSize;
  final Function buttonFunction;

  CommomButton({
    this.buttonColor,
    this.buttonFunction,
    this.buttonText,
    this.buttonTextColor,
    this.buttonTextSize
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: this.buttonColor,
      splashColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      onPressed: () => this.buttonFunction(),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          this.buttonText,
          style: GoogleFonts.comfortaa(
            textStyle: TextStyle(
              fontSize: buttonTextSize,
              fontWeight: FontWeight.bold,
              color: this.buttonTextColor,
            )
          ),
        ),
      ),
    );
  }

}