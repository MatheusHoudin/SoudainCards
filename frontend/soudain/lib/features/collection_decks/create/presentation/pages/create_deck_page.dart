import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/commom_widgets/picture_taking.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';
import 'package:soudain/injection_container.dart';

class CreateDeckPage extends StatefulWidget {
  CollectionData collectionData;

  CreateDeckPage({this.collectionData});

  @override
  _CreateDeckPageState createState() => _CreateDeckPageState();
}

class _CreateDeckPageState extends State<CreateDeckPage> {
  TextEditingController titleController = TextEditingController();
  String pickedSubject = 'French';
  File file;
  final picker = ImagePicker();

  void getImageResult(File takenImage) {
    this.file = file;
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if(pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
    }
    BlocProvider.of<NavigationBloc>(context).add(PopEvent());
  }

  @override
  Widget build(BuildContext context) {
    double loadingHorizontalMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 30,
        mediumPorcentage: 30,
        largePorcentage: 4
      )
    );
    return CommomBaseFormPage(
      headerText: createYourDeck,
      headerTextSize: 16,
      headerBackArrowFunction: () =>
          BlocProvider.of<NavigationBloc>(context).add(PopEvent()),
      contentWidgets: [
        PictureTaking(
          takeImageFunction: (takenImage) {
            getImageResult(takenImage);
          },
        ),
        SizedBox(
          height: 20,
        ),
        DeckForm(loadingHorizontalMargin)
      ]
    );
  }

  Widget DeckForm(double loadingHorizontalMargin) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Title(14, null),
          SizedBox(height: 16,),
          Subject(14),
          SizedBox(height: 16,),
          CreateDeckButton(
            textSize: 14,
            createCollectionFunction: () => null
          )
        ],
      ),
    );
  }

  Widget Title(double textSize, String error) {
    return MainTextField(
      hint: title,
      iconData: Icons.info,
      textInputType: TextInputType.text,
      textSize: textSize,
      errorMessage: error,
      controller: titleController,
      focusNode: null,
    );
  }

  Widget Subject(double textSize) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: DropdownButton(
        value: pickedSubject,
        isExpanded: true,
        onChanged: (String value) {
          setState(() {
            pickedSubject = value;
          });
        },
        underline: Container(
          height: 2,
          color: Colors.red,
        ),
        items: ['French','Chinese','Portuguese'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: GoogleFonts.comfortaa(
                fontSize: textSize,
                color: Colors.black
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget CreateDeckButton({double textSize, Function createCollectionFunction}) {
    return CommomButton(
      buttonText: create,
      buttonColor: positiveButtonColor,
      buttonTextColor: Colors.white,
      buttonFunction: () => createCollectionFunction(),
      buttonTextSize: textSize
    );
  }
}
