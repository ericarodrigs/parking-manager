import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source_sqflite.dart';
import 'package:mockito/annotations.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';

import 'parking_local_data_source_sqflite_test.mocks.dart';

@GenerateMocks([ParkingLocalDataSourceSqflite])
void main() {
  ParkingLocalDataSourceSqflite dataSourceSqflite =
      MockParkingLocalDataSourceSqflite();

  group('Local DataSource', () {
    test('should get the list of objects that are registered', () async {
      final List<ParkingEntity> testParkingEntityList = [
        ParkingEntity(
          plate: 'ABC1234',
          checkinTime: '2023-12-13 22:56:17',
          vacancy: 3,
          isOpen: false,
          parkingCost: 0.0,
        )
      ];

      when(dataSourceSqflite.getParkingOccupied())
          .thenAnswer((_) => Future.value(testParkingEntityList));
      final result = await dataSourceSqflite.getParkingOccupied();
      expect(result, isInstanceOf<List<ParkingEntity>>());
      expect(result, testParkingEntityList);
    });
  });
}
