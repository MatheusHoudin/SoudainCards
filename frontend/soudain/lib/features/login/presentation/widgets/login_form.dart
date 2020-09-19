import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/error_dialog.dart';
import 'package:soudain/core/commom_widgets/loading_card.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/login/presentation/bloc/session_bloc.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/injection_container.dart';

class LoginForm extends StatefulWidget {
  final double textSize;
  final String passowordFieldError;
  final String emailFieldError;
  final bool isCreatingSession;

  LoginForm({
    this.textSize,
    this.passowordFieldError,
    this.emailFieldError,
    this.isCreatingSession,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Function focusFunction = (FocusNode focusNode) {
      if (!focusNode.hasFocus) {
        BlocProvider.of<SessionBloc>(context)
            .add(ValidateFieldsOnFocusLostEvent(
          email: emailController.text,
          password: passwordController.text,
          signInFormKey: formKey,
        ));
      }
    };

    emailFocusNode.addListener(() => focusFunction(emailFocusNode));
    passwordFocusNode.addListener(() => focusFunction(passwordFocusNode));
  }

  @override
  Widget build(BuildContext context) {
    double loadingCardHorizontalMargin = sl<DeviceSizeAdapter>()
        .getResponsiveSize(
            context: context,
            portraitSizeAdapter: SizeAdapter(
                isHeight: false,
                smallPorcentage: 32,
                mediumPorcentage: 32,
                largePorcentage: 30),
            landscapeSizeAdapter: SizeAdapter(
                isHeight: false,
                smallPorcentage: 25,
                mediumPorcentage: 28,
                largePorcentage: 24));
    double loadingCardHeight = sl<DeviceSizeAdapter>().getResponsiveSize(
        context: context,
        portraitSizeAdapter: SizeAdapter(
            isHeight: true,
            smallPorcentage: 6,
            mediumPorcentage: 8,
            largePorcentage: 8),
        landscapeSizeAdapter: SizeAdapter(
            isHeight: true,
            smallPorcentage: 16,
            mediumPorcentage: 8,
            largePorcentage: 8));
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Email(widget.textSize, widget.emailFieldError),
            SizedBox(
              height: 20,
            ),
            Password(widget.textSize, widget.passowordFieldError),
            SizedBox(
              height: 20,
            ),
            ForgotPasswordLink(context, widget.textSize),
            SizedBox(
              height: 10,
            ),
            widget.isCreatingSession
                ? LoadingCard(
                    horizontalMargin: loadingCardHorizontalMargin,
                    height: loadingCardHeight,
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            LogInButton(
                textSize: widget.textSize,
                loginFunction: () {
                  BlocProvider.of<SessionBloc>(context).add(CreateSessionEvent(
                      emailValue: emailController.text,
                      passwordValue: passwordController.text,
                      loginFormKey: formKey,
                      onSuccess: () => BlocProvider.of<NavigationBloc>(context)
                          .add(LoginToHomeNavigationEvent()),
                      onServerError: (message) => showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialog(
                              message: message,
                            );
                          })));
                }),
          ],
        ));
  }

  Widget Email(double textSize, String error) {
    return MainTextField(
      hint: email,
      iconData: Icons.email,
      textInputType: TextInputType.emailAddress,
      textSize: textSize,
      errorMessage: error,
      controller: this.emailController,
      focusNode: emailFocusNode,
    );
  }

  Widget Password(double textSize, String error) {
    return MainTextField(
      hint: password,
      obscure: true,
      iconData: Icons.lock,
      textSize: textSize,
      errorMessage: error,
      controller: this.passwordController,
      focusNode: passwordFocusNode,
    );
  }

  Widget ForgotPasswordLink(BuildContext context, double textSize) {
    return InkWell(
      onTap: () => BlocProvider.of<NavigationBloc>(context)
          .add(NavigateToForgotPasswordPageEvent()),
      child: Text(
        forgotYourPassword,
        textAlign: TextAlign.center,
        style: GoogleFonts.comfortaa(
            textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: textSize)),
      ),
    );
  }

  Widget LogInButton({double textSize, Function loginFunction}) {
    return CommomButton(
        buttonText: signIn,
        buttonColor: positiveButtonColor,
        buttonTextColor: Colors.white,
        buttonFunction: () => loginFunction(),
        buttonTextSize: textSize);
  }
}
