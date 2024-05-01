import 'package:dartz/dartz.dart';
import 'package:parking_manager/shared/errors/failure.dart';

abstract class Usecases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
