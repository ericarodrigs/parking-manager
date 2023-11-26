import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/truck_repository.dart';
import 'package:parking_manager/shared/failure.dart';
import 'package:parking_manager/shared/usecases.dart';

class GetTrucks implements Usecases<TruckEntity, NoParams> {
  final TruckRepository repository;

  GetTrucks({
    required this.repository,
  });

  @override
  Future<Either<Failure, TruckEntity>> call(NoParams params) async {
    return await repository.getTrucks();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
