import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/usecase/base_usecase.dart';
import 'package:soudain/features/collection/create/data/models/collection.dart';
import 'package:soudain/features/collection/create/domain/repository/collection_repository.dart';

class CollectionCreateUseCase extends BaseUseCase<Collection,CollectionParams> {
  final CollectionRepository collectionRepository;

  CollectionCreateUseCase({
    this.collectionRepository
  });

  @override
  Future<Either<Failure, Collection>> call(CollectionParams params) async {
    final response = await collectionRepository.save(Collection(
      name: params.name,
      description: params.description,
      image: params.image
    ));

    return response;
  }

}

class CollectionParams extends Equatable {
  final String name;
  final String description;
  final String image;

  CollectionParams({
    this.name,
    this.description,
    this.image
  });

  @override
  List<Object> get props => [
    this.name,
    this.description,
    this.image
  ];

}