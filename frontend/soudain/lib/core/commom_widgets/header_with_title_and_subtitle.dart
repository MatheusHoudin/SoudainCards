import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/injection_container.dart';

class HeaderWithTitleAndSubtitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function backFunction;

  HeaderWithTitleAndSubtitle({this.title,this.subtitle,this.backFunction});

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
    );
    return Container(
      margin: EdgeInsets.only(
        top: 16,
        bottom: 6,
        right: 10,
        left: 10
      ),
      child: Row(
        children: <Widget>[
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
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  this.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.comfortaa(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22
                  ),
                ),
                Text(
                  this.subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.comfortaa(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
