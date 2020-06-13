import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soudain/core/commom_widgets/header_with_back_arrow_and_text.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:soudain/features/login/presentation/bloc/session_bloc.dart';
import 'package:soudain/features/signup/presentation/bloc/sign_up_bloc.dart';
import 'package:soudain/injection_container.dart';
class CommomBaseFormPage extends StatelessWidget {
  final String headerText;
  final double headerTextSize;
  final Function headerBackArrowFunction;
  final List<Widget> contentWidgets;

  CommomBaseFormPage({
    @required this.headerText,
    @required this.contentWidgets,
    @required this.headerBackArrowFunction,
    @required this.headerTextSize
  });
  @override
  Widget build(BuildContext context) {
    double lateralMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
        portraitSizeAdapter: SizeAdapter(
          isHeight: false,
          smallPorcentage: 10,
          mediumPorcentage: 10,
          largePorcentage: 16
        ),
        landscapeSizeAdapter: SizeAdapter(
          isHeight: true,
          smallPorcentage: 30,
          mediumPorcentage: 20,
          largePorcentage: 40
        )
    );

    double topMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 10,
        mediumPorcentage: 1,
        largePorcentage: 4
      ),
      landscapeSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 4,
        mediumPorcentage: 4,
        largePorcentage: 4
      )
    );

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            HeaderWithBackArrowAndText(
              headerText: this.headerText,
              textSize: this.headerTextSize,
              backFunction: () => this.headerBackArrowFunction(),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: lateralMargin,
                  right: lateralMargin,
                  top: topMargin
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.1
                    ),
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider<SessionBloc>(
                          create: (context) => sl<SessionBloc>(),
                        ),
                        BlocProvider<SignUpBloc>(
                          create: (context) => sl<SignUpBloc>(),
                        ),
                        BlocProvider<ForgotPasswordBloc>(
                          create: (context) => sl<ForgotPasswordBloc>(),
                        )
                      ],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: this.contentWidgets
                      ),
                    )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}