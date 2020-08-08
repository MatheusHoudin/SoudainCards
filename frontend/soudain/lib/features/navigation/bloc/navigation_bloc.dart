import 'dart:async';
import 'package:soudain/features/collection_decks/presentation/pages/collection_decks_page.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soudain/features/collection/create/presentation/pages/collection_creation.dart';
import 'package:soudain/features/forgot_password/presentation/pages/forgot_password.dart';
import 'package:soudain/features/home/presentation/pages/home.dart';
import 'package:soudain/features/login/presentation/pages/login_page.dart';
import 'package:soudain/features/main_page_view/presentation/pages/main_page_view.dart';
import 'package:soudain/features/signup/presentation/pages/sign_up_page.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationBloc({this.navigatorKey});

  @override
  NavigationState get initialState => NavigationInitial();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    NavigatorState state = navigatorKey.currentState;
    if (event is LoginToHomeNavigationEvent) {
      state.pushReplacement(MaterialPageRoute(builder: (context) => MainPageView()));
    }else if(event is PopEvent) {
      state.pop();
    }else if(event is NavigateToForgotPasswordPageEvent) {
      state.push(MaterialPageRoute(builder: (context) => ForgotPassword()));
    }else if(event is NavigateToSignUpPageEvent) {
      state.push(MaterialPageRoute(builder: (context) => SignUpPage()));
    }else if(event is HomeToLoginNavigationEvent) {
      state.push(MaterialPageRoute(builder: (context) => LoginPage()));
    }else if(event is NavigateToCollectionCreationPageEvent) {
      state.push(MaterialPageRoute(builder: (context) => CollectionCreation(updateCollectionsFunction: event.updateCollectionsFunction,)));
    }else if(event is NavigateToCollectionDecksPageEvent) {
      state.push(MaterialPageRoute(builder: (context) => CollectionDecksPage(collection: event.collection,)));
    }
  }
}
