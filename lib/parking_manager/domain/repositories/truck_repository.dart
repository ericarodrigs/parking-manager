import 'package:dartz/dartz.dart';
import 'package:parking_manager/parking_manager/data/models/truck_model.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';
import 'package:parking_manager/shared/failure.dart';

abstract class TruckRepository {
  Future<Either<Failure, TruckEntity>> getTrucks();
  Future<Either<Failure, bool>> registerTruck(TruckModel truckModel);
  Future<Either<Failure, bool>> updateTruck(TruckModel truckModel);
  Future<Either<Failure, bool>> deleteTruck(String id);
}
