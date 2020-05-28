import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/failures.dart';

abstract class BaseUseCase<Type,Params> {
  Future<Either<Failure,Type>> call(Params params);
}