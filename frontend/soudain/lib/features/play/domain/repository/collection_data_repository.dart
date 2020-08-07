import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';

abstract class CollectionDataRepository {
  Future<Either<Failure,List<CollectionData>>> getCollections();
}