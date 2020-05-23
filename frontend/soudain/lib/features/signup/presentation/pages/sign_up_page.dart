import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/custom_rich_text.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';

class SignUpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CommomBaseFormPage(
      headerText: 'Create your Soudain account',
      headerBackArrowFunction: () => Navigator.pop(context),
      headerTextSize: 20,
      contentWidgets: [
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
    return CustomRichText(
      mainText: 'Already have an account? ',
      featuredText: 'LOG IN',
      onTap: () => Navigator.pop(context),
    );
  }
}