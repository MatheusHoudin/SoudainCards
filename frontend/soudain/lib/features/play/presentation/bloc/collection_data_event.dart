part of 'collection_data_bloc.dart';

abstract class CollectionDataEvent extends Equatable {
  const CollectionDataEvent();
}

class GetCollectionsData extends CollectionDataEvent {
  @override
  List<Object> get props => [];
}
