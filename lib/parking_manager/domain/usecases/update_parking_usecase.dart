import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/shared/failure.dart';
import 'package:parking_manager/shared/usecases.dart';

class UpdateParkingUseCase implements Usecases<void, Params> {
  final ParkingRepository repository;

  UpdateParkingUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.updateParking(params.parkingEntity);
  }
}

class Params extends Equatable {
  final ParkingEntity parkingEntity;

  const Params({
    required this.parkingEntity,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
