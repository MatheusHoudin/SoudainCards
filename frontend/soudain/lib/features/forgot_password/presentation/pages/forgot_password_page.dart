import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/custom_rich_text.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:soudain/features/forgot_password/presentation/widgets/forgot_password_form.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/injection_container.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double headerTextSize = sl<DeviceSizeAdapter>().getResponsiveSize(
        context: context,
        portraitSizeAdapter: SizeAdapter(
            isHeight: false,
            smallPorcentage: 5,
            mediumPorcentage: 5.5,
            largePorcentage: 4),
        landscapeSizeAdapter: SizeAdapter(
            isHeight: true,
            smallPorcentage: 6,
            mediumPorcentage: 6,
            largePorcentage: 4));
    double lockIconSize = sl<DeviceSizeAdapter>().getResponsiveSize(
        context: context,
        portraitSizeAdapter: SizeAdapter(
            isHeight: true,
            smallPorcentage: 4,
            mediumPorcentage: 10,
            largePorcentage: 14),
        landscapeSizeAdapter: SizeAdapter(
            isHeight: true,
            smallPorcentage: 20,
            mediumPorcentage: 20,
            largePorcentage: 18));
    double textSize = sl<DeviceSizeAdapter>().getResponsiveSize(
        context: context,
        portraitSizeAdapter: SizeAdapter(
            isHeight: false,
            smallPorcentage: 4,
            mediumPorcentage: 4.5,
            largePorcentage: 4),
        landscapeSizeAdapter: SizeAdapter(
            isHeight: true,
            smallPorcentage: 4.5,
            mediumPorcentage: 4.5,
            largePorcentage: 4));
    return CommomBaseFormPage(
      headerText: recoverPassword,
      headerTextSize: headerTextSize,
      headerBackArrowFunction: () =>
          BlocProvider.of<NavigationBloc>(context).add(PopEvent()),
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
        ForgotPasswordFormWidget(),
        SizedBox(
          height: 30,
        ),
        LogInLink(context, textSize)
      ],
    );
  }

  Widget ForgotPasswordFormWidget() {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (buildContext, state) {
        if (state is ForgotPasswordFormState) {
          return ForgotPasswordForm(
            emailError: state.emailError,
            isRequestingPasswordReset: state.isRequestingPasswordReset,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget LockIcon(BuildContext context, double iconSize) {
    return Container(
      height: iconSize,
      width: iconSize,
      child: Image.asset(
        lockerImage,
      ),
    );
  }

  Widget Instructions(double textSize) {
    return Text(
      forgotPasswordInstructions,
      textAlign: TextAlign.center,
      style: GoogleFonts.comfortaa(
          textStyle: TextStyle(
        fontSize: textSize,
        color: Colors.black,
      )),
    );
  }

  Widget SoudainTeam(double textSize) {
    return Text(
      bySoudainTeam,
      textAlign: TextAlign.center,
      style: GoogleFonts.comfortaa(
          textStyle: TextStyle(
              fontSize: textSize,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget LogInLink(BuildContext context, double textSize) {
    return CustomRichText(
      mainText: doYouRememberIt,
      featuredText: signIn,
      onTap: () => BlocProvider.of<NavigationBloc>(context).add(PopEvent()),
      textSize: textSize,
    );
  }
}
