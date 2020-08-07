import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/usecase/base_usecase.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';
import 'package:soudain/features/play/domain/repository/collection_data_repository.dart';

class GetCollectionsDataUsecase extends BaseUseCase<List<CollectionData>,CollectionDataParams> {
  final CollectionDataRepository repository;

  GetCollectionsDataUsecase({this.repository});

  @override
  Future<Either<Failure, List<CollectionData>>> call(CollectionDataParams params) async {
    final result = await repository.getCollections();

    return result;
  }

}

class CollectionDataParams extends Equatable {
  @override
  List<Object> get props => [];

}