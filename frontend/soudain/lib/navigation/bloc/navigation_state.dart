part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
}

class NavigationInitial extends NavigationState {
  @override
  List<Object> get props => [];
}
