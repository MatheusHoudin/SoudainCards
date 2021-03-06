part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class LoginToHomeNavigationEvent extends NavigationEvent {

  @override
  List<Object> get props => [];
}

class HomeToLoginNavigationEvent extends NavigationEvent {

  @override
  List<Object> get props => [];
}

class NavigateToSignUpPageEvent extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class PopEvent extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class NavigateToForgotPasswordPageEvent extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class NavigateToCollectionDecksPageEvent extends NavigationEvent {
  final CollectionData collection;

  NavigateToCollectionDecksPageEvent({this.collection});

  @override
  List<Object> get props => [];
}

class NavigateToDeckCreationPageEvent extends NavigationEvent {
  final CollectionData collection;

  NavigateToDeckCreationPageEvent({this.collection});

  @override
  List<Object> get props => [];
}

class NavigateToCollectionCreationPageEvent extends NavigationEvent {
  final Function updateCollectionsFunction;

  NavigateToCollectionCreationPageEvent({this.updateCollectionsFunction});

  @override
  List<Object> get props => [];
}