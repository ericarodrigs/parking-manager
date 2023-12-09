import 'package:dartz/dartz.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/shared/failure.dart';

abstract class ParkingRepository {
  Future<Either<Failure, List<ParkingEntity>>> getParking();
  Future<Either<Failure, bool>> registerParking(ParkingEntity parkingEntity);
  Future<Either<Failure, bool>> updateParking(ParkingEntity parkingEntity);
  Future<Either<Failure, bool>> deleteParking(String id);
}
