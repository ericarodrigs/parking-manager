import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/shared/errors/failure.dart';
import 'package:parking_manager/shared/usecase/usecases.dart';

class RegisterParkingUseCase implements Usecases<void, Params> {
  final ParkingRepository repository;

  RegisterParkingUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.registerParking(params.parkingEntity);
  }
}

class Params extends Equatable {
  final ParkingEntity parkingEntity;

  const Params({
    required this.parkingEntity,
  });

  @override
  List<Object> get props => [parkingEntity];
}
