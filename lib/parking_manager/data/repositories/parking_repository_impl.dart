import 'package:dartz/dartz.dart';
import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source.dart';
import 'package:parking_manager/parking_manager/data/models/parking_model.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/shared/errors/exceptions.dart';
import 'package:parking_manager/shared/errors/failure.dart';

class ParkingRepositoryImpl implements ParkingRepository {
  final ParkingLocalDataSource parkingLocalDataSource;

  ParkingRepositoryImpl({
    required this.parkingLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ParkingEntity>>> getHistory(
      String dateSearch) async {
    try {
      final response = await parkingLocalDataSource.getHistory(dateSearch);
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<ParkingEntity>>> getParkingOccupied() async {
    try {
      final response = await parkingLocalDataSource.getParkingOccupied();
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, void>> registerParking(
      ParkingEntity parkingEntity) async {
    try {
      final response = await parkingLocalDataSource
          .registerParking(ParkingModel.fromEntity(parkingEntity));
      return Right(response);
    } on ConnectionException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateParking(
      ParkingEntity parkingEntity) async {
    try {
      final response = await parkingLocalDataSource
          .updateParking(ParkingModel.fromEntity(parkingEntity));
      return Right(response);
    } on ConnectionException {
      return Left(DatabaseFailure());
    }
  }
}
