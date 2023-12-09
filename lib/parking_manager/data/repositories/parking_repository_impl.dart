import 'package:dartz/dartz.dart';
import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/shared/exceptions.dart';
import 'package:parking_manager/shared/failure.dart';

class ParkingRepositoryImpl implements ParkingRepository {
  final ParkingLocalDataSource parkingLocalDataSource;

  ParkingRepositoryImpl({
    required this.parkingLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ParkingEntity>>> getParking() async {
    try {
      final response = await parkingLocalDataSource.getParking();
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> registerParking(
      ParkingEntity parkingEntity) async {
    try {
      final response = await parkingLocalDataSource.registerParking(
        ParkingEntity(
          plate: parkingEntity.plate,
          checkinTime: parkingEntity.checkinTime,
          checkoutTime: parkingEntity.checkoutTime,
          vacancy: parkingEntity.vacancy,
        ),
      );
      return Right(response);
    } on ConnectionException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateParking(
      ParkingEntity parkingEntity) async {
    try {
      final response = await parkingLocalDataSource.updateParking(
        ParkingEntity(
          plate: parkingEntity.plate,
          checkinTime: parkingEntity.checkinTime,
          checkoutTime: parkingEntity.checkoutTime,
          vacancy: parkingEntity.vacancy,
        ),
      );
      return Right(response);
    } on ConnectionException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteParking(String id) {
    // TODO: implement deleteParking
    throw UnimplementedError();
  }
}
