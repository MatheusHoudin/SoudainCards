import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/loading_card.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/home/presentation/bloc/user_data_bloc.dart';
import 'file:///C:/Users/mathe/OneDrive/Documentos/GitHub/SoudainCards/frontend/soudain/lib/core/commom_widgets/deck_format.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  void initState() {
    BlocProvider.of<UserDataBloc>(context).add(GetUserDataEvent(
      onError: (message) => showToast(message, position: ToastPosition.bottom, duration: Duration(seconds: 2)),
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: DeckFormat(
                centerWidget: OvalRedBall(),
                cardsMargin: 10,
                cardBorderRadius: 20,
                cardColor: Colors.white,
                secondaryColor: Colors.white,
                onPressed: null,
                isLeftMargin: true,
              ),
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Welcome(),
                    SizedBox(height: 6,),
                    Expanded(
                      child: BlocBuilder<UserDataBloc, UserDataState>(
                        builder: (context, state) {
                          if (state is UserDataInitialState) {
                            return Container();
                          }else if(state is LoadingUserDataState) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 18
                              ),
                              child: LoadingCard(
                                height: 16,
                                horizontalMargin: 80,
                              ),
                            );
                          }else if(state is LoadedUserDataState) {
                            return UserInfo(state.userDataModel.avatar, state.userDataModel.name);
                          }else if(state is SessionDoesNotExistState || state is UserDataDoesNotExistState){
                            return GoToLoginPageWidget();
                          }else if(state is ErrorState){
                            return GoToLoginPageWidget();
                          }else{
                            return Container();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Welcome() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'WELCOME TO\n',
        style: GoogleFonts.comfortaa(
          color: Colors.white,
          fontSize: 18
        ),
        children: [
          TextSpan(
            text: 'SOUDAIN',
            style: GoogleFonts.comfortaa(
               color: Colors.white,
               fontSize: 26,
               fontWeight: FontWeight.bold
            )
          )
        ]
      ),
    );
  }

  Widget UserInfo(String image, String name){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            width: 66,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: image != null ? NetworkImage(image) : AssetImage('assets/images/person.png')
              )
            ),

          ),
        ),
        SizedBox(height: 6,),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }

  Widget GoToLoginPageWidget(){
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 18
      ),
      child: CommomButton(
        buttonColor: positiveButtonColor,
        buttonText: 'Sign Up',
        buttonTextColor: Colors.white,
        buttonTextSize: 20,
        buttonPadding: 8,
        buttonFunction: () => BlocProvider.of<NavigationBloc>(context).add(HomeToLoginNavigationEvent()),
      ),
    );
  }
}