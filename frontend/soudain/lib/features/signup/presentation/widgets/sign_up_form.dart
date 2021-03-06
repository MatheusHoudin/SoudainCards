import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/error_dialog.dart';
import 'package:soudain/core/commom_widgets/loading_card.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/features/signup/presentation/bloc/sign_up_bloc.dart';
import 'package:soudain/injection_container.dart';

class SignUpForm extends StatefulWidget {
  final double textSize;
  final String nameFieldError;
  final String emailFieldError;
  final String passwordFieldError;
  final String passwordConfirmationFieldError;
  final bool isCreatingAccount;

  SignUpForm(
      {this.textSize,
      this.isCreatingAccount,
      this.passwordFieldError,
      this.emailFieldError,
      this.nameFieldError,
      this.passwordConfirmationFieldError});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController passwordConfirmationController =
      new TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordConfirmationFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Function focusFunction = (FocusNode focusNode) {
      if (!focusNode.hasFocus) {
        BlocProvider.of<SignUpBloc>(context).add(ValidateFieldsOnFocusLostEvent(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
          passwordConfirmation: passwordConfirmationController.text,
          signUpFormKey: formKey,
        ));
      }
    };
    nameFocusNode.addListener(() => focusFunction(nameFocusNode));
    emailFocusNode.addListener(() => focusFunction(emailFocusNode));
    passwordFocusNode.addListener(() => focusFunction(passwordFocusNode));
    passwordConfirmationFocusNode
        .addListener(() => focusFunction(passwordConfirmationFocusNode));
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordConfirmationFocusNode.dispose();
    super.dispose();
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
          Name(widget.textSize, widget.nameFieldError),
          SizedBox(
            height: 20,
          ),
          Email(widget.textSize, widget.emailFieldError),
          SizedBox(
            height: 20,
          ),
          Password(widget.textSize, widget.passwordFieldError),
          SizedBox(
            height: 20,
          ),
          PasswordConfirmation(
              widget.textSize, widget.passwordConfirmationFieldError),
          SizedBox(
            height: 20,
          ),
          widget.isCreatingAccount
              ? LoadingCard(
                  horizontalMargin: loadingCardHorizontalMargin,
                  height: loadingCardHeight,
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          SignUpButton(
              textSize: widget.textSize,
              function: () {
                BlocProvider.of<SignUpBloc>(context).add(CreateAccountEvent(
                    email: emailController.text,
                    password: passwordController.text,
                    name: nameController.text,
                    passwordConfirmation: passwordConfirmationController.text,
                    signUpFormKey: formKey,
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
      ),
    );
  }

  Widget Name(double textSize, String error) {
    return MainTextField(
      hint: name,
      iconData: Icons.person,
      textSize: textSize,
      controller: nameController,
      errorMessage: error,
      focusNode: nameFocusNode,
    );
  }

  Widget Email(double textSize, String error) {
    return MainTextField(
      hint: email,
      iconData: Icons.email,
      textInputType: TextInputType.emailAddress,
      textSize: textSize,
      controller: emailController,
      errorMessage: error,
      focusNode: emailFocusNode,
    );
  }

  Widget Password(double textSize, String error) {
    return MainTextField(
      hint: password,
      iconData: Icons.lock,
      obscure: true,
      textSize: textSize,
      controller: passwordController,
      errorMessage: error,
      focusNode: passwordFocusNode,
    );
  }

  Widget PasswordConfirmation(double textSize, String error) {
    return MainTextField(
      hint: passwordConfirmation,
      iconData: Icons.lock,
      obscure: true,
      textSize: textSize,
      controller: passwordConfirmationController,
      errorMessage: error,
      focusNode: passwordConfirmationFocusNode,
    );
  }

  Widget SignUpButton({double textSize, Function function}) {
    return CommomButton(
      buttonText: signUp,
      buttonColor: secondaryColor,
      buttonTextColor: Colors.white,
      buttonFunction: () => function(),
      buttonTextSize: textSize,
    );
  }
}
