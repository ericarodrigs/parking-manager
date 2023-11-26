import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_manager/parking_manager/domain/repositories/truck_repository.dart';
import 'package:parking_manager/shared/failure.dart';
import 'package:parking_manager/shared/usecases.dart';

class DeleteTruck implements Usecases<bool, Params> {
  final TruckRepository repository;

  DeleteTruck({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.deleteTruck(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({
    required this.id,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
