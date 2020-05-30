import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/forgot_password/presentation/pages/forgot_password.dart';
import 'package:soudain/features/login/presentation/bloc/session_bloc.dart';

class LoginForm extends StatefulWidget {
  final double textSize;
  final String passowordFieldError;
  final String emailFieldError;
  final bool isCreatingSession;

  LoginForm({
    this.textSize,
    this.passowordFieldError,
    this.emailFieldError,
    this.isCreatingSession
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Email(widget.textSize,widget.emailFieldError),
          SizedBox(
            height: 20,
          ),
          Password(widget.textSize,widget.passowordFieldError),
          SizedBox(
            height: 20,
          ),
          ForgotPasswordLink(context, widget.textSize),
          widget.isCreatingSession ?
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: MediaQuery.of(context).size.width * 0.3,
                  right: MediaQuery.of(context).size.width * 0.3
                ),
                height: 60,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
          :
              Container(),
          SizedBox(
            height: 20,
          ),
          LogInButton(
            textSize: widget.textSize,
            loginFunction: () {
              BlocProvider.of<SessionBloc>(context).add(CreateSessionEvent(
                  emailValue: emailController.text,
                  passwordValue: passwordController.text,
                  loginFormKey: formKey
              ));
            }
          ),
        ],
      )
    );
  }

  Widget Email(double textSize, String error){
    return MainTextField(
      hint: 'Email',
      iconData: Icons.email,
      textInputType: TextInputType.emailAddress,
      textSize: textSize,
      errorMessage: error,
      controller: this.emailController,
    );
  }

  Widget Password(double textSize, String error){
    return MainTextField(
      hint: 'Password',
      obscure: true,
      iconData: Icons.lock,
      textSize: textSize,
      errorMessage: error,
      controller: this.passwordController,
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

  Widget LogInButton({double textSize, Function loginFunction}){
    return CommomButton(
        buttonText: 'Log In',
        buttonColor: positiveButtonColor,
        buttonTextColor: Colors.white,
        buttonFunction: () => loginFunction(),
        buttonTextSize: textSize
    );
  }
}