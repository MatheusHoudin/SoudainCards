part of 'user_data_bloc.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();
}

class GetUserDataEvent extends UserDataEvent {
  @override
  List<Object> get props => [];

}
