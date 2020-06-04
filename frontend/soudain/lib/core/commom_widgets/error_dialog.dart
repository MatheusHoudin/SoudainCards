import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  ErrorDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sentiment_dissatisfied,
            color: primaryColor,
            size: 60,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              message,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}