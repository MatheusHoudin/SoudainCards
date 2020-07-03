part of 'user_data_bloc.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();
}

class GetUserDataEvent extends UserDataEvent {
  Function onError;

  GetUserDataEvent({this.onError});

  @override
  List<Object> get props => [];

}
