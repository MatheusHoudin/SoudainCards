import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soudain/features/forgot_password/presentation/pages/forgot_password.dart';
import 'package:soudain/features/home/presentation/pages/home.dart';
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
      state.pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }else if(event is PopEvent) {
      state.pop();
    }else if(event is NavigateToForgotPasswordPageEvent) {
      state.push(MaterialPageRoute(builder: (context) => ForgotPassword()));
    }else if(event is NavigateToSignUpPageEvent) {
      state.push(MaterialPageRoute(builder: (context) => SignUpPage()));
    }
  }
}
