import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSectionError extends StatelessWidget {
  final String imageAsset;
  final String message;

  MainSectionError({this.imageAsset,this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Text(
              this.message,
              textAlign: TextAlign.center,
              style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )
              ),
            ),
            SizedBox(height: 20,),
            Image.asset(
              imageAsset,
            )
          ],
        ),
      ),
    );
  }
}
