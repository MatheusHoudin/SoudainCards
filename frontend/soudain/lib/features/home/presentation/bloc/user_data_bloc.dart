import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/home/data/model/user_data_model.dart';
import 'package:soudain/features/home/domain/usecase/user_data_use_case.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final UserDataUseCase useCase;

  UserDataBloc({this.useCase});

  @override
  UserDataState get initialState => UserDataInitialState();

  @override
  Stream<UserDataState> mapEventToState(
    UserDataEvent event,
  ) async* {
    if (event is GetUserDataEvent) {
      yield LoadingUserDataState();

      final response = await useCase(UserDataParams());

      yield* response.fold(
        (failure) async* {
          if(failure is UserDataDoesNotExistFailure) {
            print('userdata does not');
            yield UserDataDoesNotExistState();
          }else if(failure is ServerFailure) {
            yield ErrorState();
            event.onError('There was an error when trying to get your profile data');
            print('failure');
          }else if(failure is SessionDoesNotExistFailure) {
            print('session does not exist');
            yield SessionDoesNotExistState();
          }
        },
        (userDataModel) async* {
          yield LoadedUserDataState(userDataModel: userDataModel);
        }
      );
    }
  }
}
