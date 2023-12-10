import 'package:dartz/dartz.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/shared/failure.dart';

abstract class ParkingRepository {
  Future<Either<Failure, List<ParkingEntity>>> getParking();
  Future<Either<Failure, List<ParkingEntity>>> getParkingOccupied();
  Future<Either<Failure, void>> registerParking(ParkingEntity parkingEntity);
  Future<Either<Failure, void>> updateParking(ParkingEntity parkingEntity);
}
