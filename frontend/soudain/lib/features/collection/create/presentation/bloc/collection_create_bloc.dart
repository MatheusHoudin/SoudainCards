import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/collection/create/domain/usecases/collection_create_use_case.dart';

part 'collection_create_event.dart';
part 'collection_create_state.dart';

class CollectionCreateBloc extends Bloc<CollectionCreateEvent, CollectionCreateState> {
  final CollectionCreateUseCase useCase;

  CollectionCreateBloc({this.useCase});

  @override
  CollectionCreateState get initialState => CollectionCreateFormState(
      isCreatingCollection: false,
      nameFieldError: null
  );

  @override
  Stream<CollectionCreateState> mapEventToState(
      CollectionCreateEvent event,
      ) async* {
    if( event is CreateCollectionEvent ) {
      if(event.name == null || event.name.isEmpty) {
        yield CollectionCreateFormState(
            isCreatingCollection: true,
            nameFieldError: collectionNameIsNotValid
        );
      }else{
        yield CollectionCreateFormState(
            isCreatingCollection: true,
            nameFieldError: null
        );

        final response = await useCase(CollectionParams(
            name: event.name,
            description: event.description,
            image: event.image
        ));

        yield* response.fold(
                (failure) async* {
              if(failure is CollectionAlreadyExistsFailure) {
                yield  CollectionCreateFormState(
                    isCreatingCollection: false,
                    nameFieldError: collectionAlreadyExistsValid
                );
              }else if(failure is ImageDoesNotExistFailure) {
                yield  CollectionCreateFormState(
                    isCreatingCollection: false,
                    nameFieldError: null
                );

                event.onServerError('There was an error while uploading the collection image');
              }else{
                yield  CollectionCreateFormState(
                    isCreatingCollection: false,
                    nameFieldError: null
                );
                String message = failure is ServerFailure ? unexpectedServerError : noInternetConnection;
                event.onServerError(message);
              }

              event.collectionCreateFormKey.currentState.validate();
            },
                (collection) async* {
              event.onSuccess();
            }
        );
      }

    }
  }

}
