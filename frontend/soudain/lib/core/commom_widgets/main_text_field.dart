import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/constants/colors.dart';

class MainTextField extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final bool obscure;
  final TextInputType textInputType;

  MainTextField({
    this.hint,
    this.iconData,
    this.obscure = false,
    this.textInputType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: TextField(
        obscureText: obscure,
        keyboardType: textInputType,
        style: CustomTextStyle(),

        decoration: InputDecoration(

          prefixIcon: Icon(
            iconData,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 16
          ),
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: CustomTextStyle(),
        ),
      ),
    );
  }

  TextStyle CustomTextStyle() {
    return GoogleFonts.comfortaa(
        textStyle: TextStyle(
          color: textFieldHintColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )
    );
  }

}