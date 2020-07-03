import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleContentSection extends StatelessWidget {
  final String title;
  final Widget content;

  TitleContentSection({
    this.title,
    this.content
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 14),
          child: Text(
            this.title,
            style: GoogleFonts.comfortaa(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
        ),
        Expanded(
          child: content,
        )
      ],
    );
  }
}