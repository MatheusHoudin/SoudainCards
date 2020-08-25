import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/commom_widgets/deck_format.dart';
import 'package:soudain/core/commom_widgets/header_with_title_and_subtitle.dart';
import 'package:soudain/core/commom_widgets/study_deck_front.dart';
import 'package:soudain/core/commom_widgets/title_content_section.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';
import 'package:soudain/injection_container.dart';

class CollectionDecksPage extends StatelessWidget {
  final CollectionData collection;

  CollectionDecksPage({this.collection});

  @override
  Widget build(BuildContext context) {
    double addButtomMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 30,
        mediumPorcentage: 30,
        largePorcentage: 10
      )
    );
    double cardsSectionHeight = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 40,
        mediumPorcentage: 35,
        largePorcentage: 30
      )
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              HeaderWithTitleAndSubtitle(
                title: collection.title,
                subtitle: 'Collection',
                backFunction: () => BlocProvider.of<NavigationBloc>(context).add(PopEvent()),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 4
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: CollectionDetailsWidget(),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.14,
                          margin: EdgeInsets.only(
                            left: addButtomMargin,
                            right: addButtomMargin,
                            top: 10
                          ),
                          child: DeckFormat(
                            centerWidget: OvalRedBall(
                              icon: Icons.add,
                            ),
                            cardsMargin: 10,
                            cardBorderRadius: 20,
                            cardColor: Colors.white,
                            secondaryColor: Colors.white,
                            onPressed: () => BlocProvider.of<NavigationBloc>(context).add(NavigateToDeckCreationPageEvent(
                              collection: this.collection
                            )),
                            isLeftMargin: true,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          height: cardsSectionHeight,
                          child: TitleContentSection(
                            title: 'Decks to review',
                            leftPadding: 0,
                            content: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              separatorBuilder: (_,i) => SizedBox(width: 20,),
                              itemBuilder: (_,index) => Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                margin: EdgeInsets.only(
                                    right: index == 3 ? 10 : 0
                                ),
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
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          margin: EdgeInsets.only(bottom: 20),
                          height: cardsSectionHeight,
                          child: TitleContentSection(
                            title: 'Collection decks',
                            leftPadding: 0,
                            content: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              separatorBuilder: (_,i) => SizedBox(width: 20,),
                              itemBuilder: (_,index) => Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                margin: EdgeInsets.only(
                                    right: index == 3 ? 10 : 0
                                ),
                                child: DeckFormat(
                                  centerWidget: StudyDeckFront(
                                    hasDecksToStudy: false,
                                  ),
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
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget CollectionDetailsWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Card(
            margin: EdgeInsets.only(
              right: 10,
              top: 20,
              bottom: 20
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            elevation: 4,
            child: Hero(
              tag: collection.id,
              child: Image.network(
                collection.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Text(
            collection.description,
            textAlign: TextAlign.justify,
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.comfortaa(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        )
      ],
    );
  }

}