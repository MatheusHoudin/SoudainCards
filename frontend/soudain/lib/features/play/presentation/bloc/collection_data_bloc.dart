import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/constants/texts.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';
import 'package:soudain/features/play/domain/usecase/get_collections_data_usecase.dart';

part 'collection_data_event.dart';
part 'collection_data_state.dart';

class CollectionDataBloc extends Bloc<CollectionDataEvent, CollectionDataState> {

  final GetCollectionsDataUsecase useCase;

  CollectionDataBloc({this.useCase});

  @override
  CollectionDataState get initialState => CollectionDataInitial();

  @override
  Stream<CollectionDataState> mapEventToState(
    CollectionDataEvent event,
  ) async* {
    if(event is GetCollectionsData) {
      yield LoadingCollections();

      final result = await useCase(CollectionDataParams());

      yield* result.fold(
        (failure) async* {
          print(failure);
          if(failure is NoInternetConnectionFailure) {
            yield CollectionDataError(
              message: noInternetConnection
            );
          }else{
            yield CollectionDataError(
              message: unexpectedServerError
            );
          }
        },
        (result) async* {
          print(result);
          if(result.length > 0) {
            yield LoadedCollections(
                collections: result
            );
          }else{
            yield ThereAreNoCollections();
          }
        }
      );
    }
  }
}
