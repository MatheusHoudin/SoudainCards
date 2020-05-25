import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/custom_rich_text.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/injection_container.dart';

class SignUpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double headerTextSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 5,
        mediumPorcentage: 5,
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
      headerText: 'Create your Soudain account',
      headerBackArrowFunction: () => Navigator.pop(context),
      headerTextSize: headerTextSize,
      contentWidgets: [
        SizedBox(
          height: 10,
        ),
        Name(textSize),
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
        PasswordConfirmation(textSize),
        SizedBox(
          height: 30,
        ),
        SignUpButton(textSize),
        SizedBox(
          height: 30,
        ),
        LogInLink(context, textSize)
      ],
    );
  }


  Widget Name(double textSize){
    return MainTextField(
      hint: 'Name',
      iconData: Icons.person,
      textSize: textSize,
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
      iconData: Icons.lock,
      obscure: true,
      textSize: textSize,
    );
  }

  Widget PasswordConfirmation(double textSize){
    return MainTextField(
      hint: 'Password Confirmation',
      iconData: Icons.lock,
      obscure: true,
      textSize: textSize,
    );
  }

  Widget SignUpButton(double textSize){
    return CommomButton(
      buttonText: 'Sign Up',
      buttonColor: secondaryColor,
      buttonTextColor: Colors.white,
      buttonFunction: () => null,
      buttonTextSize: textSize,
    );
  }

  Widget LogInLink(BuildContext context, double textSize){
    return CustomRichText(
      mainText: 'Already have an account? ',
      featuredText: 'LOG IN',
      onTap: () => Navigator.pop(context),
      textSize: textSize,
    );
  }
}