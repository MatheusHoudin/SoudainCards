import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soudain/core/commom_widgets/deck_format.dart';
import 'package:soudain/core/commom_widgets/loading_card.dart';
import 'package:soudain/core/commom_widgets/study_deck_front.dart';
import 'package:soudain/core/commom_widgets/title_content_section.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';
import 'package:soudain/features/play/presentation/bloc/collection_data_bloc.dart';
import 'package:soudain/features/play/presentation/widgets/deck_collection.dart';
import 'package:soudain/injection_container.dart';
import 'package:soudain/core/constants/colors.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {

  @override
  void initState() {
    BlocProvider.of<CollectionDataBloc>(context).add(GetCollectionsData());
    super.initState();
  }
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
    double loadingCardHorizontalMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 36,
        mediumPorcentage: 40,
        largePorcentage: 40
      )
    );
    double loadingCardHeight = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 15,
        mediumPorcentage: 13,
        largePorcentage: 13
      )
    );

    return SafeArea(
      child: Container(
        color: secondaryColor,
        padding: EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.18,
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
                onPressed: () => BlocProvider.of<NavigationBloc>(context).add(NavigateToCollectionCreationPageEvent(
                  updateCollectionsFunction: () => BlocProvider.of<CollectionDataBloc>(context).add(GetCollectionsData())
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
            SizedBox(height: 40,),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,

              child: TitleContentSection(
                title: 'My Collections',
                leftPadding: 10,
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<CollectionDataBloc,CollectionDataState>(
                    builder: (context, state) {
                      if(state is LoadedCollections) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            spacing: 18,
                            children: state.collections.map((c) => DeckCollectionContainer(
                              context,
                              c
                            )).toList(),
                          ),
                        );
                      }else if(state is LoadingCollections) {
                        return Center(
                          child: LoadingCard(
                            height: loadingCardHeight,
                            horizontalMargin: loadingCardHorizontalMargin,
                            backColor: primaryColor,
                          ),
                        );
                      }else if(state is CollectionDataError){
                        return Center(
                          child: Text(state.message),
                        );
                      }else{
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget DeckCollectionContainer(BuildContext context, CollectionData collectionData) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.25,
      child: GestureDetector(
        onTap: () => BlocProvider.of<NavigationBloc>(context).add(NavigateToCollectionDecksPageEvent(
          collection: collectionData
        )),
        child: DeckCollection(collectionData: collectionData,),
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
            icon: Icons.add,
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