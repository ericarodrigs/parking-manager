import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source_sqflite.dart';
import 'package:mockito/annotations.dart';
import 'package:parking_manager/parking_manager/data/models/parking_model.dart';

import '../../mocks/mocks.dart';
import 'parking_local_data_source_sqflite_test.mocks.dart';

@GenerateMocks([ParkingLocalDataSourceSqflite])
void main() {
  ParkingLocalDataSourceSqflite dataSourceSqflite =
      MockParkingLocalDataSourceSqflite();

  group('Local DataSource', () {
    test('should get the list of objects that are registered', () async {
      when(dataSourceSqflite.getParkingOccupied())
          .thenAnswer((_) => Future.value(testParkingModelList));
      final result = await dataSourceSqflite.getParkingOccupied();
      expect(result, isInstanceOf<List<ParkingModel>>());
      expect(result, testParkingModelList);
    });
  });
}
