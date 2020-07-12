import 'package:flutter/material.dart';
import 'package:soudain/core/commom_widgets/commom_base_form_page.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/deck_format.dart';
import 'package:soudain/core/commom_widgets/main_text_field.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';
import 'package:soudain/injection_container.dart';

class CollectionCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double addButtomMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 20,
        mediumPorcentage: 10,
        largePorcentage: 10
      )
    );
    return CommomBaseFormPage(
      headerText: 'Create your collection',
      headerTextSize: 16,
      //headerBackArrowFunction: () => BlocProvider.of<NavigationBloc>(context).add(PopEvent()),
      contentWidgets: [
        Picture(context, addButtomMargin),
        SizedBox(height: 20,),
        CollectionForm()
      ],
    );
  }
  
  Widget Picture(BuildContext context, double addButtomMargin) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      margin: EdgeInsets.only(
        left: addButtomMargin,
        right: addButtomMargin,
        top: 10
      ),
      child: DeckFormat(
        centerWidget: OvalRedBall(
          isAddButton: true,
        ),
        cardsMargin: 10,
        cardBorderRadius: 20,
        cardColor: Colors.white,
        secondaryColor: Colors.white,
        onPressed: () => null,
        isLeftMargin: true,
      ),
    );
  }

  Widget CollectionForm(){
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Email(14, null),
          SizedBox(height: 16,),
          Description(14, null),
          SizedBox(height: 16,),
          CreateCollectionButton(loginFunction: null, textSize: 14)
        ],
      ),
    );
  }

  Widget Email(double textSize, String error){
    return MainTextField(
      hint: 'Title',
      iconData: Icons.info,
      textInputType: TextInputType.text,
      textSize: textSize,
      errorMessage: error,
      controller: null,
      focusNode: null,
    );
  }
  Widget Description(double textSize, String error){
    return MainTextField(
      hint: 'Description',
      iconData: Icons.description,
      textInputType: TextInputType.text,
      textSize: textSize,
      errorMessage: error,
      controller: null,
      focusNode: null,
    );
  }

  Widget CreateCollectionButton({double textSize, Function loginFunction}){
    return CommomButton(
      buttonText: 'Create',
      buttonColor: positiveButtonColor,
      buttonTextColor: Colors.white,
      buttonFunction: () => loginFunction(),
      buttonTextSize: textSize
    );
  }
}