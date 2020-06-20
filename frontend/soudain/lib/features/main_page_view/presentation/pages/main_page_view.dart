import 'package:flutter/material.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/home/presentation/pages/home.dart';
import 'package:soudain/features/main_page_view/presentation/widgets/cards_floating_button.dart';

class MainPageView extends StatefulWidget {
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  bool isFloatingButtonOpen;
  PageController pageController;

  @override
  void initState() {
    this.isFloatingButtonOpen = false;
    this.pageController = PageController(initialPage: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Curve pageViewAnimationCurve = Curves.easeIn;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: PageView(
        controller: pageController,
        children: [
          Home(),
          Scaffold(body: Center(child: Text('PLAY'),),),
          Scaffold(body: Center(child: Text('PROGRESS'),),),
        ],
      ),
      floatingActionButton: Container(
        height: 100,
        margin: EdgeInsets.only(left: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                width: isFloatingButtonOpen ? 500 : 80,
                child: CardsFloatingButton(
                  icon: Icons.home,
                  isDeckStackOpen: this.isFloatingButtonOpen,
                  onDeckTap: () {
                    print('ONTAOP');
                    setState(() {
                      this.isFloatingButtonOpen = true;
                    });
                  },
                  nagivateToHomeFunction: () => this.pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 500),
                    curve: pageViewAnimationCurve
                  ),
                  nagivateToPlayFunction: () => this.pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 500),
                    curve: pageViewAnimationCurve
                  ),
                  nagivateToProgressFunction: () => this.pageController.animateToPage(
                    2,
                    duration: Duration(milliseconds: 500),
                    curve: pageViewAnimationCurve
                  ),
                ),
              ),
            ),
            SizedBox(height: 16,),
            AnimatedOpacity(
              opacity: this.isFloatingButtonOpen ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: CloseButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget CloseButton() {
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
            setState(() {
              this.isFloatingButtonOpen = false;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(4),
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