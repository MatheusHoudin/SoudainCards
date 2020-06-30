part of 'user_data_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
}

class UserDataInitialState extends UserDataState {
  @override
  List<Object> get props => [];
}

class LoadingUserDataState extends UserDataState {
  @override
  List<Object> get props => [];
}

class LoadedUserDataState extends UserDataState {
  final UserDataModel userDataModel;

  LoadedUserDataState({
    this.userDataModel
  });

  @override
  List<Object> get props => [this.userDataModel];
}

class UserDataDoesNotExistState extends UserDataState {
  @override
  List<Object> get props => [];
}

class SessionDoesNotExistState extends UserDataState {
  @override
  List<Object> get props => [];
}

class ErrorState extends UserDataState {
  @override
  List<Object> get props => [];
}
