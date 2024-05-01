import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source_sqflite.dart';
import 'package:parking_manager/parking_manager/data/repositories/parking_repository_impl.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';

import '../../mocks/mocks.dart';
import 'parking_repository_test.mocks.dart';

@GenerateMocks([ParkingLocalDataSourceSqflite])
void main() {
  ParkingLocalDataSourceSqflite dataSourceSqflite =
      MockParkingLocalDataSourceSqflite();
  ParkingRepository repository =
      ParkingRepositoryImpl(parkingLocalDataSource: dataSourceSqflite);

  group('parkingLocalDataSourceSqflite', () {
    test('should get the list of objects that are registered', () async {
      when(dataSourceSqflite.getParkingOccupied())
          .thenAnswer((_) => Future.value(testParkingModelList));
      final result = await repository.getParkingOccupied();
      expect(result, const Right(testParkingModelList));
    });
  });
}
