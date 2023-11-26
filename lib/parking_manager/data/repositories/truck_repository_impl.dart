import 'package:dartz/dartz.dart';
import 'package:parking_manager/parking_manager/data/datasource/truck_local_data_source.dart';
import 'package:parking_manager/parking_manager/data/models/truck_model.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/truck_repository.dart';
import 'package:parking_manager/shared/exceptions.dart';
import 'package:parking_manager/shared/failure.dart';

class TruckRepositoryImpl implements TruckRepository {
  final TruckLocalDataSource truckLocalDataSource;

  TruckRepositoryImpl({
    required this.truckLocalDataSource,
  });

  @override
  Future<Either<Failure, List<TruckEntity>>> getTrucks() async {
    try {
      final response = await truckLocalDataSource.getTrucks();
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> registerTruck(TruckModel truckModel) async {
    try {
      final response = await truckLocalDataSource.registerTruck(
        TruckModel(
          plate: truckModel.plate,
          checkinTime: truckModel.checkinTime,
          checkoutTime: truckModel.checkoutTime,
          vacancy: truckModel.vacancy,
          driver: truckModel.driver,
          checkoutValue: truckModel.checkoutValue,
        ),
      );
      return Right(response);
    } on ConnectionException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateTruck(TruckModel truckModel) async {
    try {
      final response = await truckLocalDataSource.updateTruck(
        TruckModel(
          plate: truckModel.plate,
          checkinTime: truckModel.checkinTime,
          checkoutTime: truckModel.checkoutTime,
          vacancy: truckModel.vacancy,
          driver: truckModel.driver,
          checkoutValue: truckModel.checkoutValue,
        ),
      );
      return Right(response);
    } on ConnectionException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTruck(String id) {
    // TODO: implement deleteTruck
    throw UnimplementedError();
  }
}
