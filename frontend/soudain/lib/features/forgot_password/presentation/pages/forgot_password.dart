import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/custom_rich_text.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/injection_container.dart';

class ForgotPassword extends StatelessWidget {

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
    double lockIconSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 4,
        mediumPorcentage: 10,
        largePorcentage: 14
      ),
      landscapeSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 20,
        mediumPorcentage: 20,
        largePorcentage: 18
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
      headerText: 'Recover password',
      headerTextSize: headerTextSize,
      headerBackArrowFunction: () => Navigator.pop(context),
      contentWidgets: [
        LockIcon(context, lockIconSize),
        SizedBox(
          height: 20,
        ),
        Instructions(textSize),
        SizedBox(
          height: 10,
        ),
        SoudainTeam(textSize),
        SizedBox(
          height: 30,
        ),
        Email(textSize),
        SizedBox(
          height: 20,
        ),
        ResetPasswordButton(textSize),
        SizedBox(
          height: 30,
        ),
        LogInLink(context, textSize)
      ],
    );
  }
  
  Widget LockIcon(BuildContext context, double iconSize){
    return Container(
      height: iconSize,
      width: iconSize,
      child: Image.asset(
        'assets/images/lock.png',
      ),
    );
  }
  
  Widget Instructions(double textSize){
    return Text(
      'Enter your email and we will send you instructions on how to reset your password',
      textAlign: TextAlign.center,
      style: GoogleFonts.comfortaa(
        textStyle: TextStyle(
          fontSize: textSize,
          color: Colors.black,

        )
      ),
    );
  }
  
  Widget SoudainTeam(double textSize){
    return Text(
      'By Soudain Team',
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
  
  Widget ResetPasswordButton(double textSize){
    return CommomButton(
      buttonText: 'Reset password',
      buttonTextSize: textSize,
      buttonTextColor: Colors.black,
      buttonFunction: () => null,
      buttonColor: lightYellow,
    );
  }

  Widget LogInLink(BuildContext context, double textSize){
    return CustomRichText(
      mainText: 'Do you remember it? ',
      featuredText: 'LOG IN',
      onTap: () => Navigator.pop(context),
      textSize: textSize,
    );
  }
}