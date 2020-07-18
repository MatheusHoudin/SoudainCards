import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:soudain/injection_container.dart';
import 'package:soudain/core/commom_widgets/commom_button.dart';
import 'package:soudain/core/commom_widgets/loading_card.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/home/presentation/bloc/user_data_bloc.dart';
import 'package:soudain/core/commom_widgets/deck_format.dart';
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
    double cardBorderRadius = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 2,
        mediumPorcentage: 1.8,
        largePorcentage: 2
      ),
    );
    double cardPadding = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 3,
        mediumPorcentage: 3,
        largePorcentage: 3
      ),
    );
    double userDataPadding = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 2,
        mediumPorcentage: 3,
        largePorcentage: 4
      ),
    );
    double cardsMarging = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 2,
        mediumPorcentage: 2,
        largePorcentage: 2.5
      ),
    );
    double welcomeTextSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 4.5,
        mediumPorcentage: 4,
        largePorcentage: 3.5
      ),
    );
    double soudainTextSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 7,
        mediumPorcentage: 6,
        largePorcentage: 5.5
      ),
    );
    double signUpPadding = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 4,
        mediumPorcentage: 0.5,
        largePorcentage: 1.4
      ),
    );
    double loadingCardPadding = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 2,
        mediumPorcentage: 1,
        largePorcentage: 2
      ),
    );
    double loadingCardHorizontalMargin = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 16,
        mediumPorcentage: 18,
        largePorcentage: 20
      ),
    );
    double userAvatarWidth = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: false,
        smallPorcentage: 18,
        mediumPorcentage: 13,
        largePorcentage: 20
      ),
    );
    double userNameTextSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 2,
        mediumPorcentage: 3,
        largePorcentage: 2.4
      ),
    );
    double avatarNameSeparatorSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 2,
        mediumPorcentage: 0.5,
        largePorcentage: 0.5
      ),
    );
    double avatarSoudainSeparatorSize = sl<DeviceSizeAdapter>().getResponsiveSize(
      context: context,
      portraitSizeAdapter: SizeAdapter(
        isHeight: true,
        smallPorcentage: 2,
        mediumPorcentage: 1,
        largePorcentage: 1.6
      ),
    );
    return Card(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(cardBorderRadius))
      ),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: cardPadding,
                bottom: cardPadding,
              ),
              child: DeckFormat(
                centerWidget: OvalRedBall(),
                cardsMargin: cardsMarging,
                cardBorderRadius: 20,
                cardColor: Colors.white,
                secondaryColor: Colors.white,
                onPressed: null,
                isLeftMargin: true,
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10,
                top: userDataPadding,
                bottom: userDataPadding,
              ),
              child: Column(
                
                children: [
                  Welcome(
                    welcomeTextSize,
                    soudainTextSize
                  ),
                  SizedBox(height: avatarSoudainSeparatorSize,),
                  BlocBuilder<UserDataBloc, UserDataState>(
                    builder: (context, state) {
                      if (state is UserDataInitialState) {
                        return Container();
                      }else if(state is LoadingUserDataState) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: loadingCardPadding
                          ),
                          child: LoadingCard(
                            horizontalMargin: loadingCardHorizontalMargin,
                          ),
                        );
                      }else if(state is LoadedUserDataState) {
                        return Expanded(child: UserInfo(state.userDataModel.avatar, state.userDataModel.name,userAvatarWidth,userNameTextSize,avatarNameSeparatorSize));
                      }else if(state is SessionDoesNotExistState || state is UserDataDoesNotExistState){
                        return GoToLoginPageWidget(signUpPadding);
                      }else if(state is ErrorState){
                        return GoToLoginPageWidget(signUpPadding);
                      }else{
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget Welcome(double welcomeTextSize, double soudainTextSize) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'WELCOME TO\n',
        style: GoogleFonts.comfortaa(
          color: Colors.white,
          fontSize: welcomeTextSize
        ),
        children: [
          TextSpan(
            text: 'SOUDAIN',
            style: GoogleFonts.comfortaa(
               color: Colors.white,
               fontSize: soudainTextSize,
               fontWeight: FontWeight.bold
            )
          )
        ]
      ),
    );
  }

  Widget UserInfo(String image, String name,double avatarWidth,double userNameSize,double avatarNameSeparatorSize){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            width: avatarWidth,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: image != null ? NetworkImage(image) : AssetImage('assets/images/person.png')
              )
            ),

          ),
        ),
        SizedBox(height: avatarNameSeparatorSize,),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.comfortaa(
            fontSize: userNameSize,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }

  Widget GoToLoginPageWidget(double signUpPadding){
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: signUpPadding
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