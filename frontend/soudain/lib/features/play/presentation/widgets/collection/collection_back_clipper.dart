import 'package:flutter/cupertino.dart';

class CollectionBackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(20, 0.0);
    path.lineTo(20, 20);
    path.lineTo(size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);

    //path.lineTo(0.0, size.height);
    //path.lineTo(size.width, size.height);
    //path.lineTo(size.width, 40);


    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}