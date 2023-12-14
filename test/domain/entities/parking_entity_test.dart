import 'package:flutter_test/flutter_test.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';

void main() {
  var testParkingEntity = ParkingEntity(
    plate: 'ABC1234',
    checkinTime: '2023-12-13 22:56:17',
    vacancy: 3,
    isOpen: false,
    parkingCost: 0.0,
  );

  test(
    'should be a subclass of ParkingEntity',
    () async {
      expect(testParkingEntity, isA<ParkingEntity>());
    },
  );

  group('fromMap', () {
    test(
      'should return a valid entity',
      () async {
        final Map<String, dynamic> map = {
          "plate": "ABC1234",
          "checkinTime": "2023-12-13 22:56:17",
          "vacancy": 3,
          "isOpen": false,
          "parkingCost": 0.0,
        };
        final result = ParkingEntity.fromMap(map);
        expect(result.id, testParkingEntity.id);
        expect(result.plate, testParkingEntity.plate);
        expect(result.checkinTime, testParkingEntity.checkinTime);
        expect(result.vacancy, testParkingEntity.vacancy);
        expect(result.isOpen, testParkingEntity.isOpen);
        expect(result.parkingCost, testParkingEntity.parkingCost);
      },
    );
  });

  group('toMap', () {
    test(
      'should return a map containing the proper data',
      () async {
        final result = testParkingEntity.toMap();
        final expectedMap = {
          "id": null,
          "plate": "ABC1234",
          "checkinTime": "2023-12-13 22:56:17",
          "vacancy": 3,
          "isOpen": 0,
        };
        expect(result, expectedMap);
      },
    );
  });
}
