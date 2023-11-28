import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/truck_repository.dart';
import 'package:parking_manager/shared/failure.dart';
import 'package:parking_manager/shared/usecases.dart';

class UpdateTruck implements Usecases<bool, Params> {
  final TruckRepository repository;

  UpdateTruck({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.registerTruck(params.truckEntity);
  }
}

class Params extends Equatable {
  final TruckEntity truckEntity;

  const Params({
    required this.truckEntity,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
