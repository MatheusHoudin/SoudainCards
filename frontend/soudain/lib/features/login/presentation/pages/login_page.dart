import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/custom_rich_text.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/login/presentation/bloc/session_bloc.dart';
import 'package:soudain/features/login/presentation/widgets/login_form.dart';
import 'package:soudain/injection_container.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
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
        LoginFormWidget(textSize),
        SizedBox(
          height: 20,
        ),
        CreateAccountLink(context, textSize)
      ],
    );
  }

  Widget LoginFormWidget(double textSize) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (blocContext, state) {
        if (state is SessionFormState) {
          return LoginForm(
            textSize: textSize,
            emailFieldError: state.emailFieldError,
            passowordFieldError: state.passwordFieldError,
            isCreatingSession: state.isCreatingSession,
          );
        }else{
          return Container();
        }
      },
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


  Widget CreateAccountLink(BuildContext context, double textSize){
    return CustomRichText(
      mainText: 'Don\'t have an account? ',
      featuredText: 'SIGN UP',
      onTap: () => BlocProvider.of<NavigationBloc>(context).add(NavigateToSignUpPageEvent()),
      textSize: textSize,
    );
  }
}