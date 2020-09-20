import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soudain/core/commom_widgets/deck_format.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/injection_container.dart';

class PictureTaking extends StatefulWidget {
  final Function takeImageFunction;

  PictureTaking({this.takeImageFunction});

  @override
  _PictureTakingState createState() => _PictureTakingState();
}

class _PictureTakingState extends State<PictureTaking> {
  final picker = ImagePicker();

  File file;

  @override
  Widget build(BuildContext context) {
    double addButtomMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
        context: context,
        portraitSizeAdapter: SizeAdapter(
            isHeight: false,
            smallPorcentage: 20,
            mediumPorcentage: 20,
            largePorcentage: 20));
    double clipOvalPadding = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
          isHeight: false,
          smallPorcentage: 8,
          mediumPorcentage: 8,
          largePorcentage: 7),
    );
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      margin: EdgeInsets.only(
          left: addButtomMargin, right: addButtomMargin, top: 10),
      child: DeckFormat(
        centerWidget: file == null
            ? OvalRedBall(
                clipOvalPadding: clipOvalPadding,
                icon: Icons.photo_camera,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  file,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
        cardsMargin: 10,
        cardBorderRadius: 20,
        cardColor: Colors.white,
        secondaryColor: Colors.white,
        onPressed: () =>
            showDialog(context: context, builder: (_) => CameraDialog()),
        isLeftMargin: true,
      ),
    );
  }

  Widget CameraDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        'Collection image',
        style: GoogleFonts.comfortaa(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Choose the wanted source',
        style: GoogleFonts.comfortaa(),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => getImage(ImageSource.camera),
          child: Text(
            'Camera',
            style: GoogleFonts.comfortaa(
                fontWeight: FontWeight.bold, color: secondaryColor),
          ),
        ),
        FlatButton(
          onPressed: () => getImage(ImageSource.gallery),
          child: Text(
            'Gallery',
            style: GoogleFonts.comfortaa(
                fontWeight: FontWeight.bold, color: secondaryColor),
          ),
        ),
      ],
    );
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
        print(pickedFile.path);
        widget.takeImageFunction(File(pickedFile.path));
      });
    }
    BlocProvider.of<NavigationBloc>(context).add(PopEvent());
  }
}
