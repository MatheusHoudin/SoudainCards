import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:soudain/core/constants/colors.dart';
class LoadingCard extends StatefulWidget {
  final double horizontalMargin;
  final double height;
  final Color backColor;

  LoadingCard({this.horizontalMargin, this.height,this.backColor=secondaryColor});

  @override
  _LoadingCardState createState() => _LoadingCardState();
}

class _LoadingCardState extends State<LoadingCard> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  Timer flipCardTimer;


  @override
  void initState() {
    super.initState();
    flipCardTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      cardKey.currentState.toggleCard();
    });
  }

  @override
  void dispose() {
    flipCardTimer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: cardKey,
      flipOnTouch: false,
      front: Side(Colors.white),
      back: Side(widget.backColor),
    );
  }

  Widget Side(Color color){
    return Container(
      margin: EdgeInsets.only(
        left: widget.horizontalMargin,
        right: widget.horizontalMargin
      ),
      height: widget.height,
      color: color,
    );
  }
}