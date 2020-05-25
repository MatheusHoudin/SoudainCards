import 'package:flutter/material.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/custom_rich_text.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/forgot_password/presentation/pages/forgot_password.dart';
import 'package:soudain/features/signup/presentation/pages/sign_up_page.dart';
import 'package:soudain/injection_container.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double headerTextSize = sl<DeviceSizeAdapter>().getResponsiveSize(
        context: context,
        portraitSizeAdapter: SizeAdapter(
          isHeight: false,
          smallPorcentage: 5,
          mediumPorcentage: 5.5,
          largePorcentage: 4
        ),
        landscapeSizeAdapter: SizeAdapter(
          isHeight: true,
          smallPorcentage: 6,
          mediumPorcentage: 6,
          largePorcentage: 4
        )
    );
    double textSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 4,
        mediumPorcentage: 4.5,
        largePorcentage: 4
      ),
      landscapeSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 4.5,
        mediumPorcentage: 4.5,
        largePorcentage: 4
      )
    );
    return CommomBaseFormPage(
      headerText: 'Start your Soudain journey',
      headerTextSize: headerTextSize,
      headerBackArrowFunction: () => null,
      contentWidgets: [
        SizedBox(
          height: 10,
        ),
        GoogleButton(textSize),
        SizedBox(
          height: 30,
        ),
        FacebookButton(textSize),
        SizedBox(
          height: 20,
        ),
        Or(textSize),
        SizedBox(
          height: 20,
        ),
        Email(textSize),
        SizedBox(
          height: 20,
        ),
        Password(textSize),
        SizedBox(
          height: 20,
        ),
        ForgotPasswordLink(context, textSize),
        SizedBox(
          height: 20,
        ),
        LogInButton(textSize),
        SizedBox(
          height: 20,
        ),
        CreateAccountLink(context, textSize)
      ],
    );
  }

  Widget FacebookButton(double textSize){
    return CommomButton(
      buttonText: 'Log In with Facebook',
      buttonColor: secondaryColor,
      buttonTextColor: Colors.white,
      buttonFunction: () => null,
      buttonTextSize: textSize,
    );
  }

  Widget GoogleButton(double textSize){
    return CommomButton(
      buttonText: 'Log In with Google',
      buttonColor: Colors.white,
      buttonTextColor: Colors.black,
      buttonFunction: () => null,
      buttonTextSize: textSize,
    );
  }

  Widget Or(double textSize){
    return Text(
      'OR',
      textAlign: TextAlign.center,
      style: GoogleFonts.comfortaa(
        textStyle: TextStyle(
          fontSize: textSize,
          color: Colors.white,
          fontWeight: FontWeight.bold
        )
      ),
    );
  }

  Widget Email(double textSize){
    return MainTextField(
      hint: 'Email',
      iconData: Icons.email,
      textInputType: TextInputType.emailAddress,
      textSize: textSize,
    );
  }

  Widget Password(double textSize){
    return MainTextField(
      hint: 'Password',
      obscure: true,
      iconData: Icons.lock,
      textSize: textSize,
    );
  }

  Widget ForgotPasswordLink(BuildContext context, double textSize){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword())),
      child: Text(
        'Forgot your password?',
        textAlign: TextAlign.center,
        style: GoogleFonts.comfortaa(
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: textSize
          )
        ),
      ),
    );
  }

  Widget LogInButton(double textSize){
    return CommomButton(
      buttonText: 'Log In',
      buttonColor: positiveButtonColor,
      buttonTextColor: Colors.white,
      buttonFunction: () => null,
      buttonTextSize: textSize
    );
  }

  Widget CreateAccountLink(BuildContext context, double textSize){
    return CustomRichText(
      mainText: 'Don\'t have an account? ',
      featuredText: 'SIGN UP',
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
      textSize: textSize,
    );
  }
}