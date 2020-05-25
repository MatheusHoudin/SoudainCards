import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/injection_container.dart';

class HeaderWithBackArrowAndText extends StatelessWidget {
  final String headerText;
  final double textSize;
  final Function backFunction;

  HeaderWithBackArrowAndText({
    this.headerText,
    this.textSize,
    this.backFunction
  });

  @override
  Widget build(BuildContext context) {
    double backArrowSize = sl<DeviceSizeAdapter>().getResponsiveSize(
        context: context,
        portraitSizeAdapter: SizeAdapter(
          isHeight: false,
          smallPorcentage: 8,
          mediumPorcentage: 7,
          largePorcentage: 6
        ),
        landscapeSizeAdapter: SizeAdapter(
          isHeight: true,
          smallPorcentage: 8,
          mediumPorcentage: 6,
          largePorcentage: 6
        )
    );
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => this.backFunction(),
            child: Container(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: backArrowSize,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              headerText,
              textAlign: TextAlign.center,
              style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: textSize
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}