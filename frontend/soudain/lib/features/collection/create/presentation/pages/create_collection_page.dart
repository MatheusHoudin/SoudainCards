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
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/collection/create/presentation/bloc/collection_create_bloc.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/injection_container.dart';

class CreateCollectionPage extends StatefulWidget {
  final Function updateCollectionsFunction;

  CreateCollectionPage({this.updateCollectionsFunction});

  @override
  _CreateCollectionPageState createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  final formKey = GlobalKey<FormState>();

  File file;

  final picker = ImagePicker();

  TextEditingController nameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  void getImageResult(File takenImage) {
    this.file = takenImage;
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
      headerText: createYourCollection,
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
                        collectionCreatedSuccessfully,
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
      hint: title,
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
      hint: description,
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
        buttonText: create,
        buttonColor: positiveButtonColor,
        buttonTextColor: Colors.white,
        buttonFunction: () => createCollectionFunction(),
        buttonTextSize: textSize);
  }
}
