import 'package:flutter/material.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/custom_rich_text.dart';
import 'package:soudain/core/commom_widgets/header_with_back_arrow_and_text.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/features/forgot_password/presentation/pages/forgot_password.dart';
import 'package:soudain/features/signup/presentation/pages/sign_up_page.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommomBaseFormPage(
      headerText: 'Start your Soudain journey',
      headerTextSize: 22,
      headerBackArrowFunction: () => null,
      contentWidgets: [
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
        ForgotPasswordLink(context),
        SizedBox(
          height: 20,
        ),
        LogInButton(),
        SizedBox(
          height: 20,
        ),
        CreateAccountLink(context)
      ],
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

  Widget ForgotPasswordLink(BuildContext context){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword())),
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
    return CustomRichText(
      mainText: 'Don\'t have an account? ',
      featuredText: 'SIGN UP',
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
    );
  }
}