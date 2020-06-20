import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/home/presentation/widgets/logo.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Logo(
                centerWidget: OvalRedBall(),
                cardsMargin: 10,
                cardBorderRadius: 20,
                cardColor: Colors.white,
                secondaryColor: Colors.white,
                onPressed: null,
                isLeftMargin: true,
              ),
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Welcome(),
                    SizedBox(height: 6,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipOval(
                              child: Image.network('https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                            ),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            'Mary Hellen',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Welcome() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'WELCOME TO\n',
        style: GoogleFonts.comfortaa(
          color: Colors.white,
          fontSize: 18
        ),
        children: [
          TextSpan(
            text: 'SOUDAIN',
            style: GoogleFonts.comfortaa(
               color: Colors.white,
               fontSize: 26,
               fontWeight: FontWeight.bold
            )
          )
        ]
      ),
    );
  }
}