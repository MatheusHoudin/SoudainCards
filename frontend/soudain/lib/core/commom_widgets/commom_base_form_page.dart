import 'package:flutter/material.dart';
import 'package:soudain/core/commom_widgets/header_with_back_arrow_and_text.dart';
import 'package:soudain/core/constants/colors.dart';

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
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.width * 0.07
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: this.contentWidgets
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