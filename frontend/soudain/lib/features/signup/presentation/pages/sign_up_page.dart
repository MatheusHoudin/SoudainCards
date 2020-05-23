import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_buttom.dart';
import 'package:soudain/core/commom_widgets/header_with_back_arrow_and_text.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/login/presentation/pages/login_page.dart';

class SignUpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            HeaderWithBackArrowAndText(
              headerText: 'Create your Soudain account',
              textSize: 20,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                    top: MediaQuery.of(context).size.width * 0.07
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Name(),
                      SizedBox(
                        height: 20,
                      ),
                      Email(),
                      SizedBox(
                        height: 20,
                      ),
                      Password(),
                      SizedBox(
                        height: 20,
                      ),
                      PasswordConfirmation(),
                      SizedBox(
                        height: 30,
                      ),
                      SignUpButton(),
                      SizedBox(
                        height: 30,
                      ),
                      LogInLink(context)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Name(){
    return MainTextField(
      hint: 'Name',
      iconData: Icons.person,
    );
  }

  Widget Email(){
    return MainTextField(
      hint: 'Email',
      iconData: Icons.email,
      textInputType: TextInputType.emailAddress,
    );
  }

  Widget Password(){
    return MainTextField(
      hint: 'Password',
      iconData: Icons.lock,
      obscure: true,
    );
  }

  Widget PasswordConfirmation(){
    return MainTextField(
      hint: 'Password Confirmation',
      iconData: Icons.lock,
      obscure: true,
    );
  }

  Widget SignUpButton(){
    return CommomButton(
      buttonText: 'Sign Up',
      buttonColor: secondaryColor,
      buttonTextColor: Colors.white,
      buttonFunction: () => null,
      buttonTextSize: 20,
    );
  }

  Widget LogInLink(BuildContext context){
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Already have an account? ',
            style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                )
            ),
            children: <TextSpan>[
              TextSpan(
                  text: 'LOG IN',
                  style: GoogleFonts.comfortaa(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      )
                  )
              )
            ]
        ),
      ),
    );
  }
}