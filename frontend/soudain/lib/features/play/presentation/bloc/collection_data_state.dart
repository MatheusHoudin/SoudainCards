part of 'collection_data_bloc.dart';

abstract class CollectionDataState extends Equatable {
  const CollectionDataState();
}

class CollectionDataInitial extends CollectionDataState {
  @override
  List<Object> get props => [];
}

class LoadingCollections extends CollectionDataState {
  @override
  List<Object> get props => [];
}

class LoadedCollections extends CollectionDataState {
  final List<CollectionData> collections;

  LoadedCollections({this.collections});

  @override
  List<Object> get props => [this.collections];
}

class CollectionDataError extends CollectionDataState {
  final String message;

  CollectionDataError({this.message});

  @override
  List<Object> get props => [this.message];
}