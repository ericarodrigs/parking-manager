import 'package:flutter_test/flutter_test.dart';
import 'package:parking_manager/parking_manager/data/models/parking_model.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';

import '../../mocks/mocks.dart';

void main() {
  test(
    'should be a subclass of ParkingEntity',
    () async {
      expect(testParkingModel, isA<ParkingEntity>());
    },
  );

  group('fromMap', () {
    test(
      'should return a valid model',
      () async {
        final Map<String, dynamic> map = {
          "plate": "ABC1234",
          "checkinTime": "2023-12-13 22:56:17",
          "vacancy": 3,
          "parkingCost": 0.0,
        };
        final result = ParkingModel.fromMap(map);
        expect(result.id, testParkingModel.id);
        expect(result.plate, testParkingModel.plate);
        expect(result.checkinTime, testParkingModel.checkinTime);
        expect(result.vacancy, testParkingModel.vacancy);
        expect(result.parkingCost, testParkingModel.parkingCost);
      },
    );
  });

  group('toMap', () {
    test(
      'should return a map containing the proper data',
      () async {
        final result = testParkingModel.toMap();
        final expectedMap = {
          "id": null,
          "plate": "ABC1234",
          "checkinTime": "2023-12-13 22:56:17",
          "vacancy": 3,
        };
        expect(result, expectedMap);
      },
    );
  });

  group('fromEntity', () {
    test(
      'should return a valid model from a entity',
      () async {
        final result = ParkingModel.fromEntity(testParkingEntity);

        expect(result, testParkingModel);
      },
    );
  });
}
