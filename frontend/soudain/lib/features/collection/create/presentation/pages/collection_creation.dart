import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/deck_format.dart';
import 'package:soudain/core/commom_widgets/error_dialog.dart';
import 'package:soudain/core/commom_widgets/loading_card.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/collection/create/presentation/bloc/collection_create_bloc.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/injection_container.dart';

class CollectionCreation extends StatefulWidget {
  @override
  _CollectionCreationState createState() => _CollectionCreationState();
}

class _CollectionCreationState extends State<CollectionCreation> {
  final formKey = GlobalKey<FormState>();

  File file;

  final picker = ImagePicker();

  TextEditingController nameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double addButtomMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 20,
        mediumPorcentage: 20,
        largePorcentage: 20
      )
    );
    return CommomBaseFormPage(
      headerText: 'Create your collection',
      headerTextSize: 16,
      headerBackArrowFunction: () =>
          BlocProvider.of<NavigationBloc>(context).add(PopEvent()),
      contentWidgets: [
        Picture(context, addButtomMargin),
        SizedBox(
          height: 20,
        ),
        CollectionForm()
      ],
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      file = File(pickedFile.path);
    });
  }

  Widget Picture(BuildContext context, double addButtomMargin) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      margin: EdgeInsets.only(
          left: addButtomMargin, right: addButtomMargin, top: 10),
      child: DeckFormat(
        centerWidget: file == null ?
        OvalRedBall(
          icon: Icons.photo_camera,
        )
        :
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10
          ),
          child: ClipOval(
            child: Image.file(
              file,

            ),
          ),
        ),
        cardsMargin: 10,
        cardBorderRadius: 20,
        cardColor: Colors.white,
        secondaryColor: Colors.white,
        onPressed: getImage,
        isLeftMargin: true,
      ),
    );
  }

  Widget CollectionForm() {
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
                  horizontalMargin: 120,
                  height: 60,
                )
                    :
                Container(),
                CreateCollectionButton(
                  loginFunction: () => BlocProvider.of<CollectionCreateBloc>(context).add(CreateCollectionEvent(
                    name: nameController.text,
                    description: descriptionController.text,
                    image: file != null ? file.path : null,
                    collectionCreateFormKey: formKey,
                    onSuccess: () => BlocProvider.of<NavigationBloc>(context).add(PopEvent()),
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

  Widget CreateCollectionButton({double textSize, Function loginFunction}) {
    return CommomButton(
        buttonText: 'Create',
        buttonColor: positiveButtonColor,
        buttonTextColor: Colors.white,
        buttonFunction: () => loginFunction(),
        buttonTextSize: textSize);
  }
}
