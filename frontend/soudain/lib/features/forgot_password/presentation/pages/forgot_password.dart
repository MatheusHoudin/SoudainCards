import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/custom_rich_text.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';

class ForgotPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CommomBaseFormPage(
      headerText: 'Recover password',
      headerTextSize: 22,
      headerBackArrowFunction: () => Navigator.pop(context),
      contentWidgets: [
        LockIcon(context),
        SizedBox(
          height: 20,
        ),
        Instructions(),
        SizedBox(
          height: 10,
        ),
        SoudainTeam(),
        SizedBox(
          height: 30,
        ),
        Email(),
        SizedBox(
          height: 20,
        ),
        ResetPasswordButton(),
        SizedBox(
          height: 30,
        ),
        LogInLink(context)
      ],
    );
  }
  
  Widget LockIcon(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 0.2,
      child: Image.asset(
        'assets/images/lock.png',
      ),
    );
  }
  
  Widget Instructions(){
    return Text(
      'Enter your email and we will send you instructions on how to reset your password',
      textAlign: TextAlign.center,
      style: GoogleFonts.comfortaa(
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.black,

        )
      ),
    );
  }
  
  Widget SoudainTeam(){
    return Text(
      'By Soudain Team',
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
  
  Widget ResetPasswordButton(){
    return CommomButton(
      buttonText: 'Reset password',
      buttonTextSize: 20,
      buttonTextColor: Colors.black,
      buttonFunction: () => null,
      buttonColor: lightYellow,
    );
  }

  Widget LogInLink(BuildContext context){
    return CustomRichText(
      mainText: 'Do you remember it? ',
      featuredText: 'LOG IN',
      onTap: () => Navigator.pop(context),
    );
  }
}