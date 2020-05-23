import 'package:flutter/material.dart';
import 'package:soudain/core/commom_widgets/header_with_back_arrow_and_text.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_buttom.dart';
import 'package:soudain/features/signup/presentation/pages/sign_up_page.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      body: SafeArea(
        child: Column(
          children: [
            HeaderWithBackArrowAndText(
              headerText: 'Start your Soudain journey',
              textSize: 22,
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
                      GoogleButton(),
                      SizedBox(
                        height: 30,
                      ),
                      FacebookButton(),
                      SizedBox(
                        height: 20,
                      ),
                      Or(),
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
                      ForgotPasswordLink(),
                      SizedBox(
                        height: 20,
                      ),
                      LogInButton(),
                      SizedBox(
                        height: 20,
                      ),
                      CreateAccountLink(context)
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

  Widget FacebookButton(){
    return CommomButton(
      buttonText: 'Log In with Facebook',
      buttonColor: secondaryColor,
      buttonTextColor: Colors.white,
      buttonFunction: () => null,
      buttonTextSize: 20,
    );
  }

  Widget GoogleButton(){
    return CommomButton(
      buttonText: 'Log In with Google',
      buttonColor: Colors.white,
      buttonTextColor: Colors.black,
      buttonFunction: () => null,
      buttonTextSize: 20,
    );
  }

  Widget Or(){
    return Text(
      'OR',
      textAlign: TextAlign.center,
      style: GoogleFonts.comfortaa(
          textStyle: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold
          )
      ),
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
      obscure: true,
      iconData: Icons.lock,
    );
  }

  Widget ForgotPasswordLink(){
    return InkWell(
      onTap: () => null,
      child: Text(
        'Forgot your password?',
        textAlign: TextAlign.center,
        style: GoogleFonts.comfortaa(
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
          )
        ),
      ),
    );
  }

  Widget LogInButton(){
    return CommomButton(
      buttonText: 'Log In',
      buttonColor: positiveButtonColor,
      buttonTextColor: Colors.white,
      buttonFunction: () => null,
      buttonTextSize: 20,
    );
  }

  Widget CreateAccountLink(BuildContext context){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Don\'t have an account? ',
          style: GoogleFonts.comfortaa(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18
            )
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'SIGN UP',
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