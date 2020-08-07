import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleContentSection extends StatelessWidget {
  final String title;
  final double leftPadding;

  final Widget content;

  TitleContentSection({
    this.title,
    this.content,
    this.leftPadding
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 14, left: leftPadding),
          child: Title(),
        ),
        Expanded(
          child: content,
        )
      ],
    );
  }

  Widget Title(){
    return Text(
      this.title,
      style: GoogleFonts.comfortaa(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20
      ),
    );
  }
}