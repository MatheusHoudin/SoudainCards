import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/custom_rich_text.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/features/signup/presentation/bloc/sign_up_bloc.dart';
import 'package:soudain/features/signup/presentation/widgets/sign_up_form.dart';
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
            largePorcentage: 4),
        landscapeSizeAdapter: SizeAdapter(
            isHeight: true,
            smallPorcentage: 6,
            mediumPorcentage: 6,
            largePorcentage: 4));
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
      headerText: createYourSoudainAccount,
      headerBackArrowFunction: () =>
          BlocProvider.of<NavigationBloc>(context).add(PopEvent()),
      headerTextSize: headerTextSize,
      contentWidgets: [
        SizedBox(
          height: 10,
        ),
        SignUpWidget(textSize),
        SizedBox(
          height: 30,
        ),
        LogInLink(context, textSize)
      ],
    );
  }

  Widget SignUpWidget(double textSize) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state is SignUpFormState) {
          return SignUpForm(
            emailFieldError: state.emailError,
            nameFieldError: state.nameError,
            passwordFieldError: state.passwordError,
            passwordConfirmationFieldError: state.passwordConfirmationError,
            isCreatingAccount: state.isCreatingAccount,
            textSize: textSize,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget LogInLink(BuildContext context, double textSize) {
    return CustomRichText(
      mainText: alreadyHaveAnAccount,
      featuredText: signIn,
      onTap: () => BlocProvider.of<NavigationBloc>(context).add(PopEvent()),
      textSize: textSize,
    );
  }
}
