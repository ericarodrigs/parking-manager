import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/shared/failure.dart';
import 'package:parking_manager/shared/usecases.dart';

class GetParkingOccupiedUseCase
    implements Usecases<List<ParkingEntity>, NoParams> {
  final ParkingRepository repository;

  GetParkingOccupiedUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<ParkingEntity>>> call(NoParams params) async {
    return await repository.getParkingOccupied();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
