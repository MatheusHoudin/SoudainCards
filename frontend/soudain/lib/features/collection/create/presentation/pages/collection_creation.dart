import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/deck_format.dart';
import 'package:soudain/core/commom_widgets/error_dialog.dart';
import 'package:soudain/core/commom_widgets/loading_card.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/commom_widgets/picture_taking.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/collection/create/presentation/bloc/collection_create_bloc.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/injection_container.dart';

class CollectionCreation extends StatefulWidget {
  final Function updateCollectionsFunction;

  CollectionCreation({this.updateCollectionsFunction});

  @override
  _CollectionCreationState createState() => _CollectionCreationState();
}

class _CollectionCreationState extends State<CollectionCreation> {
  final formKey = GlobalKey<FormState>();

  File file;

  final picker = ImagePicker();

  TextEditingController nameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  void getImageResult(File takenImage) {
    print('GET ILE');
    print(takenImage);
    this.file = file;
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
      headerText: 'Create your collection',
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
        CollectionForm(loadingHorizontalMargin)
      ],
    );
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

  Widget CollectionForm(double loadingHorizontalMargin) {
    return BlocBuilder<CollectionCreateBloc,CollectionCreateState>(
      builder: (context, state) {
        if(state is CollectionCreateFormState) {
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Email(14, state.nameFieldError),
                SizedBox(
                  height: 16,
                ),
                Description(14, null),
                SizedBox(
                  height: 16,
                ),
                state.isCreatingCollection ?
                LoadingCard(
                  horizontalMargin: loadingHorizontalMargin,
                  height: 60,
                )
                    :
                Container(),
                SizedBox(height: 16,),
                CreateCollectionButton(
                  createCollectionFunction: () => BlocProvider.of<CollectionCreateBloc>(context).add(CreateCollectionEvent(
                    name: nameController.text,
                    description: descriptionController.text,
                    image: file != null ? file.path : null,
                    collectionCreateFormKey: formKey,
                    onSuccess: () {
                      showToast(
                        'Your collection was successfully created',
                        duration: Duration(seconds: 3),
                        position: ToastPosition.bottom,
                        textPadding: EdgeInsets.all(12),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        )
                      );
                      widget.updateCollectionsFunction();
                      BlocProvider.of<NavigationBloc>(context).add(PopEvent());
                    },
                    onServerError: (message) => showDialog(
                      context: context,
                      builder: (context) {
                        return ErrorDialog(message: message,);
                      }
                    )
                  )),
                  textSize: 14
                )
              ],
            ),
          );
        }else{
          return Container();
        }
      },
    );
  }

  Widget Email(double textSize, String error) {
    return MainTextField(
      hint: 'Title',
      iconData: Icons.info,
      textInputType: TextInputType.text,
      textSize: textSize,
      errorMessage: error,
      controller: nameController,
      focusNode: null,
    );
  }

  Widget Description(double textSize, String error) {
    return MainTextField(
      hint: 'Description',
      iconData: Icons.description,
      textInputType: TextInputType.multiline,
      textSize: textSize,
      errorMessage: error,
      controller: descriptionController,
      focusNode: null,
      maxLines: null,
    );
  }

  Widget CreateCollectionButton({double textSize, Function createCollectionFunction}) {
    return CommomButton(
        buttonText: 'Create',
        buttonColor: positiveButtonColor,
        buttonTextColor: Colors.white,
        buttonFunction: () => createCollectionFunction(),
        buttonTextSize: textSize);
  }

  Widget CameraDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      title: Text(
        'Collection image',
        style: GoogleFonts.comfortaa(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Choose the wanted source',
        style: GoogleFonts.comfortaa(
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => getImage(ImageSource.camera),
          child: Text(
            'Camera',
            style: GoogleFonts.comfortaa(
              fontWeight: FontWeight.bold,
                color: secondaryColor
            ),
          ),
        ),
        FlatButton(
          onPressed: () => getImage(ImageSource.gallery),
          child: Text(
            'Gallery',
            style: GoogleFonts.comfortaa(
              fontWeight: FontWeight.bold,
              color: secondaryColor
            ),
          ),
        ),
      ],
    );
  }
}
