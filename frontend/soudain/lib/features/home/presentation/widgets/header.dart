import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/home/presentation/widgets/logo.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Logo(),
            ),
            Expanded(
              flex: 12,
              child: Container(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}