import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/error_dialog.dart';
import 'package:soudain/core/commom_widgets/loading_card.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:soudain/injection_container.dart';

class ForgotPasswordForm extends StatefulWidget {
  final String emailError;
  final bool isRequestingPasswordReset;


  ForgotPasswordForm({this.emailError,this.isRequestingPasswordReset});

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
    double loadingCardHorizontalMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
        context: context,
        portraitSizeAdapter: SizeAdapter(
            isHeight: false,
            smallPorcentage: 32,
            mediumPorcentage: 32,
            largePorcentage: 30
        ),
        landscapeSizeAdapter: SizeAdapter(
            isHeight: false,
            smallPorcentage: 25,
            mediumPorcentage: 28,
            largePorcentage: 24
        )
    );
    double loadingCardHeight = sl<DeviceSizeAdapter>().getResponsiveSize(
        context: context,
        portraitSizeAdapter: SizeAdapter(
            isHeight: true,
            smallPorcentage: 6,
            mediumPorcentage: 8,
            largePorcentage: 8
        ),
        landscapeSizeAdapter: SizeAdapter(
            isHeight: true,
            smallPorcentage: 16,
            mediumPorcentage: 8,
            largePorcentage: 8
        )
    );
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Email(textSize),
          SizedBox(
            height: 20,
          ),
          widget.isRequestingPasswordReset ?
          LoadingCard(
            horizontalMargin: loadingCardHorizontalMargin,
            height: loadingCardHeight,
          )
              :
          Container(),
          SizedBox(
            height: 20,
          ),
          ResetPasswordButton(textSize, context)
        ],
      ),
    );
  }

  Widget Email(double textSize){
    return MainTextField(
      hint: email,
      iconData: Icons.email,
      textInputType: TextInputType.emailAddress,
      textSize: textSize,
      controller: emailTextEditingController,
      errorMessage: widget.emailError,
    );
  }

  Widget ResetPasswordButton(double textSize, BuildContext context){

    return CommomButton(
      buttonText: resetPassword,
      buttonTextSize: textSize,
      buttonTextColor: Colors.black,
      buttonFunction: () => BlocProvider.of<ForgotPasswordBloc>(context).add(RequestPasswordResetEvent(
        email: emailTextEditingController.text,
        onServerError: (message) => showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(message: message,);
            }
        ),
        onSuccess: (message) => showToast(message, position: ToastPosition.bottom),
        forgotPasswordFormKey: formKey
      )),
      buttonColor: lightYellow,
    );
  }
}
