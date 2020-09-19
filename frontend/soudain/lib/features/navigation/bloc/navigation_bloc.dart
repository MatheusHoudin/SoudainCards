import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soudain/features/collection/create/presentation/pages/create_collection_page.dart';
import 'package:soudain/features/collection_decks/create/presentation/pages/create_deck_page.dart';
import 'package:soudain/features/forgot_password/presentation/pages/forgot_password_page.dart';
import 'package:soudain/features/login/presentation/pages/login_page.dart';
import 'package:soudain/features/main_page_view/presentation/pages/main_page_view.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';
import 'package:soudain/features/signup/presentation/pages/sign_up_page.dart';

import 'file:///C:/Users/mathe/OneDrive/Documentos/GitHub/SoudainCards/frontend/soudain/lib/features/collection_decks/home/presentation/pages/collection_decks_page.dart';

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
      state.pushReplacement(
          MaterialPageRoute(builder: (context) => MainPageView()));
    } else if (event is PopEvent) {
      state.pop();
    } else if (event is NavigateToForgotPasswordPageEvent) {
      state.push(MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
    } else if (event is NavigateToSignUpPageEvent) {
      state.push(MaterialPageRoute(builder: (context) => SignUpPage()));
    } else if (event is HomeToLoginNavigationEvent) {
      state.push(MaterialPageRoute(builder: (context) => LoginPage()));
    } else if (event is NavigateToCollectionCreationPageEvent) {
      state.push(MaterialPageRoute(
          builder: (context) => CreateCollectionPage(
                updateCollectionsFunction: event.updateCollectionsFunction,
              )));
    } else if (event is NavigateToCollectionDecksPageEvent) {
      state.push(MaterialPageRoute(
          builder: (context) => CollectionDecksPage(
                collectionData: event.collection,
              )));
    } else if (event is NavigateToDeckCreationPageEvent) {
      state.push(MaterialPageRoute(
          builder: (context) => CreateDeckPage(
                collectionData: event.collection,
              )));
    }
  }
}
