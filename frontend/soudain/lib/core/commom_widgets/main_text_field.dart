import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/injection_container.dart';

class MainTextField extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final bool obscure;
  final TextInputType textInputType;
  final double textSize;

  MainTextField({
    this.hint,
    this.iconData,
    this.obscure = false,
    this.textInputType = TextInputType.text,
    this.textSize
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
        style: CustomTextStyle(textSize),

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
          hintStyle: CustomTextStyle(textSize),
        ),
      ),
    );
  }

  TextStyle CustomTextStyle(double textSize) {
    return GoogleFonts.comfortaa(
        textStyle: TextStyle(
          color: textFieldHintColor,
          fontSize: textSize,
          fontWeight: FontWeight.bold,
        )
    );
  }

}