import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_buttom.dart';
import 'package:soudain/core/constants/colors.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAppBar(),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.width * 0.05
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CommomButton(
                        buttonText: 'Log In with Google',
                        buttonColor: Colors.white,
                        buttonTextColor: Colors.black,
                        buttonFunction: () => null,
                        buttonTextSize: 20,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CommomButton(
                        buttonText: 'Log In with Facebook',
                        buttonColor: secondaryColor,
                        buttonTextColor: Colors.white,
                        buttonFunction: () => null,
                        buttonTextSize: 20,
                      ),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CustomAppBar(){
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          Text(
            'Start your Soudain journey',
            textAlign: TextAlign.center,
            style: GoogleFonts.comfortaa(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22
              )
            ),
          )
        ],
      ),
    );
  }

}