part of 'collection_create_bloc.dart';

abstract class CollectionCreateState extends Equatable {
  const CollectionCreateState();
}

class CollectionCreateFormState extends CollectionCreateState {
  final String nameFieldError;
  final bool isCreatingCollection;

  CollectionCreateFormState({
    this.nameFieldError,
    this.isCreatingCollection
  });

  @override
  List<Object> get props => [
    this.nameFieldError,
    this.isCreatingCollection
  ];
}