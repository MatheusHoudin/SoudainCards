import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/features/login/domain/usecases/create_session_use_case.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final CreateSessionUseCase createSessionUseCase;

  SessionBloc({
    this.createSessionUseCase
  });
  @override
  SessionState get initialState => FormState(loginFieldError: null, passwordFieldError: null);

  @override
  Stream<SessionState> mapEventToState(
    SessionEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
