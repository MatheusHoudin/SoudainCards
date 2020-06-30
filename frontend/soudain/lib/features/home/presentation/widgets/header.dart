import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/home/presentation/bloc/user_data_bloc.dart';
import 'package:soudain/features/home/presentation/widgets/logo.dart';
import 'package:soudain/features/home/presentation/widgets/oval_red_ball.dart';
import 'package:soudain/features/navigation/bloc/navigation_bloc.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  void initState() {
    BlocProvider.of<UserDataBloc>(context).add(GetUserDataEvent());
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
              child: Logo(
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
                            return Text('loading');
                          }else if(state is LoadedUserDataState) {
                            return UserInfo(state.userDataModel.avatar, state.userDataModel.name);
                          }else if(state is UserDataDoesNotExistState){
                            return Text('User does not exist');
                          }else if(state is SessionDoesNotExistState){
                            return GestureDetector(
                              onTap: () => BlocProvider.of<NavigationBloc>(context).add(HomeToLoginNavigationEvent()),
                              child: Container(
                                color: Colors.black,
                                height: 30,
                                width: 50,

                              ),
                            );
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
}