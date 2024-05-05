import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source_sqflite.dart';
import 'package:parking_manager/parking_manager/data/repositories/parking_repository_impl.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/shared/errors/exceptions.dart';
import 'package:parking_manager/shared/errors/failure.dart';

import '../../mocks/mocks.dart';
import 'parking_repository_test.mocks.dart';

@GenerateMocks([ParkingLocalDataSourceSqflite])
void main() {
  ParkingLocalDataSourceSqflite dataSourceSqflite =
      MockParkingLocalDataSourceSqflite();
  ParkingRepository repository =
      ParkingRepositoryImpl(parkingLocalDataSource: dataSourceSqflite);

  group('parkingLocalDataSourceSqflite - getHistory', () {
    test('should get the list of entities that are registered in a given date',
        () async {
      when(dataSourceSqflite.getHistory(testDateSearch))
          .thenAnswer((_) => Future.value(testParkingModelList));
      final result = await repository.getHistory(testDateSearch);
      expect(result, const Right(testParkingModelList));
    });

    test('should return a failure when the call is unsuccessful', () async {
      when(dataSourceSqflite.getHistory(testDateSearch))
          .thenThrow(NoDataException());
      final result = await repository.getHistory(testDateSearch);
      expect(result, Left(NoDataFailure()));
    });
  });

  group('parkingLocalDataSourceSqflite - getParkingOccupied', () {
    test('should get the list of objects that are registered', () async {
      when(dataSourceSqflite.getParkingOccupied())
          .thenAnswer((_) => Future.value(testParkingModelList));
      final result = await repository.getParkingOccupied();
      expect(result, const Right(testParkingModelList));
    });

    test('should return a failure when the call is unsuccessful', () async {
      when(dataSourceSqflite.getParkingOccupied()).thenThrow(NoDataException());
      final result = await repository.getParkingOccupied();
      expect(result, Left(NoDataFailure()));
    });
  });

  group('parkingLocalDataSourceSqflite - registerParking', () {
    test('should register a new entity', () async {
      when(dataSourceSqflite.registerParking(testParkingModel))
          .thenAnswer((_) => Future<void>.value());
      final result = await repository.registerParking(testParkingModel);
      expect(result, const Right(null));
    });

    test('should return a failure when the call is unsuccessful', () async {
      when(dataSourceSqflite.registerParking(testParkingModel))
          .thenThrow(ConnectionException());
      final result = await repository.registerParking(testParkingModel);
      expect(result, Left(DatabaseFailure()));
    });
  });

  group('parkingLocalDataSourceSqflite - updateParking', () {
    test('should update an entity already registered', () async {
      when(dataSourceSqflite.updateParking(testParkingModel))
          .thenAnswer((_) => Future<void>.value());
      final result = await repository.updateParking(testParkingModel);
      expect(result, const Right(null));
    });

    test('should return a failure when the call is unsuccessful', () async {
      when(dataSourceSqflite.updateParking(testParkingModel))
          .thenThrow(ConnectionException());
      final result = await repository.updateParking(testParkingModel);
      expect(result, Left(DatabaseFailure()));
    });
  });
}
