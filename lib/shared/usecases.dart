import 'package:dartz/dartz.dart';
import 'package:parking_manager/shared/failure.dart';

abstract class Usecases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
