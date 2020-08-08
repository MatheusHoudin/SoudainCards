import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/home/presentation/bloc/user_data_bloc.dart';
import 'package:soudain/features/home/presentation/pages/home.dart';
import 'package:soudain/features/main_page_view/presentation/widgets/cards_floating_button.dart';
import 'package:soudain/features/play/presentation/bloc/collection_data_bloc.dart';
import 'package:soudain/features/play/presentation/pages/play_page.dart';
import 'package:soudain/injection_container.dart';

class MainPageView extends StatefulWidget {
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  bool isFloatingButtonOpen;
  PageController pageController;
  IconData pageIconData;
  int currentPage;
  List<IconData> icons = [Icons.home,Icons.play_arrow,Icons.show_chart];

  @override
  void initState() {
    this.isFloatingButtonOpen = false;
    currentPage = 0;
    this.pageController = PageController(initialPage: currentPage);

    pageIconData = Icons.home;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double floatingCardHeight = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 80,
        mediumPorcentage: 18,
        largePorcentage: 16
      )
    );
    double floatingCardWidth = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 20,
        mediumPorcentage: 20,
        largePorcentage: 18
      )
    );
    double closeButtonPadding = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 0.5,
        mediumPorcentage: 1,
        largePorcentage: 2
      )
    );

    print(floatingCardHeight);
    Curve pageViewAnimationCurve = Curves.easeIn;
    return BlocProvider<CollectionDataBloc>(
      create: (context) => sl<CollectionDataBloc>(),
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: PageView(
          controller: pageController,
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
              pageIconData = icons[page];
            });
          },
          children: [
            Home(),
            PlayPage(),
            Scaffold(body: Center(child: Text('PROGRESS'),),),
          ],
        ),
        floatingActionButton: Container(
          alignment: Alignment.center,
          height: floatingCardHeight,
          margin: EdgeInsets.only(left: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: Duration(seconds: 1),
                  width: isFloatingButtonOpen ? 800 : floatingCardWidth,
                  child: CardsFloatingButton(
                    icon: pageIconData,
                    isDeckStackOpen: this.isFloatingButtonOpen,
                    onDeckTap: () {
                      setState(() {
                        this.isFloatingButtonOpen = true;
                      });
                    },
                    nagivateToHomeFunction: () {
                      this.pageController.animateToPage(
                          0,
                          duration: Duration(milliseconds: 500),
                          curve: pageViewAnimationCurve
                      );
                    },
                    nagivateToPlayFunction: () {
                      this.pageController.animateToPage(
                          1,
                          duration: Duration(milliseconds: 500),
                          curve: pageViewAnimationCurve
                      );
                    },
                    nagivateToProgressFunction: () {
                      this.pageController.animateToPage(
                          2,
                          duration: Duration(milliseconds: 500),
                          curve: pageViewAnimationCurve
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16,),
              AnimatedOpacity(
                opacity: this.isFloatingButtonOpen ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: CloseButton(closeButtonPadding),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget CloseButton(double buttonPadding) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle
      ),
      child: Material(
        shape: CircleBorder(),
        color: Colors.white,
        child: InkWell(
          onTap: (){
            Future.delayed(Duration(milliseconds: 500), (){
              setState(() {
                this.isFloatingButtonOpen = false;
              });
            });
          },
          child: Padding(
            padding: EdgeInsets.all(buttonPadding),
            child: Icon(
              Icons.close,
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}