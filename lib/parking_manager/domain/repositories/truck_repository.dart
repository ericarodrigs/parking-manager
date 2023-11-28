import 'package:dartz/dartz.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';
import 'package:parking_manager/shared/failure.dart';

abstract class TruckRepository {
  Future<Either<Failure, List<TruckEntity>>> getTrucks();
  Future<Either<Failure, bool>> registerTruck(TruckEntity truckEntity);
  Future<Either<Failure, bool>> updateTruck(TruckEntity truckEntity);
  Future<Either<Failure, bool>> deleteTruck(String id);
}
