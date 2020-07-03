import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soudain/core/commom_widgets/deck_format.dart';
import 'package:soudain/core/commom_widgets/study_deck_front.dart';
import 'package:soudain/core/commom_widgets/title_content_section.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';
import 'package:soudain/features/play/presentation/widgets/collection/collection_back_clipper.dart';

class PlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: secondaryColor,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.35,
              child: TitleContentSection(
                title: 'Decks to review',
                content: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  separatorBuilder: (_,i) => SizedBox(width: 20,),
                  itemBuilder: (_,index) => Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DeckFormat(
                      centerWidget: StudyDeckFront(),
                      cardsMargin: 10,
                      cardBorderRadius: 20,
                      cardColor: Colors.white,
                      secondaryColor: Colors.white,
                      onPressed: null,
                      isLeftMargin: true,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            ClipPath(
              clipper: CollectionBackClipper(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 120),
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget AddButton(){
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 130,
            vertical: 10
        ),
        child: DeckFormat(
          centerWidget: OvalRedBall(
            isAddButton: true,
          ),
          cardsMargin: 10,
          cardBorderRadius: 20,
          cardColor: Colors.white,
          secondaryColor: Colors.white,
          onPressed: null,
          isLeftMargin: true,
        ),
      ),
    );
  }
}