import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';

class CollectionDecksPage extends StatelessWidget {
  final CollectionData collection;

  CollectionDecksPage({this.collection});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Center(
          child: Container(
            height: 100,
            width: 100,
            child: Hero(
              tag: collection.id,
              child: Image.network(
                collection.imageUrl
              ),
            ),
          ),
        ),
      ),
    );
  }

}