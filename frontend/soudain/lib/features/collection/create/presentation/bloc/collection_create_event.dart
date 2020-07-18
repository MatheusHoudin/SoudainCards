part of 'collection_create_bloc.dart';

abstract class CollectionCreateEvent extends Equatable {
  const CollectionCreateEvent();
}

class CreateCollectionEvent extends CollectionCreateEvent {
  final String name;
  final String description;
  final String image;
  final GlobalKey<FormState> collectionCreateFormKey;
  final Function onServerError;
  final Function onSuccess;

  CreateCollectionEvent({
    this.name,
    this.image,
    this.description,
    this.onServerError,
    this.collectionCreateFormKey,
    this.onSuccess
  });

  @override
  List<Object> get props => [
    this.name,
    this.description,
    this.image
  ];
}