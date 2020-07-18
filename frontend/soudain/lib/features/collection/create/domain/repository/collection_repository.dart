import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/collection/create/data/models/collection.dart';

abstract class CollectionRepository {
  Future<Either<Failure,Collection>> save(Collection collection);
}