import 'package:flutter_test/flutter_test.dart';
import 'package:parking_manager/parking_manager/data/models/parking_model.dart';
import 'package:parking_manager/shared/utils/extensions/constants/constants.dart';
import 'package:sqflite/sqflite.dart';

import '../../mocks/mocks.dart';
import 'config_database/parking_database_initializer_test.dart';

void main() {
  setUpAll(() {
    sqfliteTestInit();
  });

  group('Local DataSource', () {
    test('registerParking', () async {
      Database db = await createDatabase();

      await db.insert(parkingTable, testParkingModel.toMap());

      final result = await db.query(parkingTable);
      var listResult = result
          .map<ParkingModel>((parking) => ParkingModel.fromMap(parking))
          .toList();
      expect(listResult.length, 1);
      expect(listResult.first, testInsertedParkingModel);

      await db.close();
    });

    test('updateParking', () async {
      Database db = await createDatabase();

      await db.insert(parkingTable, testParkingModel.toMap());
      await db.update(
        parkingTable,
        testUpdatedParkingModel.toMap(),
        where: 'id = ?',
        whereArgs: [testUpdatedParkingModel.id],
      );

      final result = await db.query(parkingTable);
      var listResult = result
          .map<ParkingModel>((parking) => ParkingModel.fromMap(parking))
          .toList();
      expect(listResult.length, 1);
      expect(listResult.first, testUpdatedParkingModel);

      await db.close();
    });

    test('getParkingOccupied', () async {
      Database db = await createDatabase();

      for (var i = 0; i < 5; i++) {
        await db.insert(parkingTable, testParkingModel.toMap());
      }

      await db.update(
        parkingTable,
        testUpdatedParkingModel.toMap(),
        where: 'id = ?',
        whereArgs: [testUpdatedParkingModel.id],
      );

      final result = await db.rawQuery(queryOcuppied);
      var listResult = result
          .map<ParkingModel>((parking) => ParkingModel.fromMap(parking))
          .toList();
      expect(listResult.length, 4);
      expect(listResult.last.id, 5);
      expect(listResult.first.checkoutTime, null);

      await db.close();
    });

    test('getHistory', () async {
      Database db = await createDatabase();
      var checkoutDate = '2023-12-14';

      await db.insert(parkingTable, testParkingModel.toMap());
      await db.update(
        parkingTable,
        testUpdatedParkingModel.toMap(),
        where: 'id = ?',
        whereArgs: [testUpdatedParkingModel.id],
      );
      final result = await db.rawQuery(queryHistory(checkoutDate));
      var listResult = result
          .map<ParkingModel>((parking) => ParkingModel.fromMap(parking))
          .toList();

      expect(listResult.length, 1);
      expect(
          listResult.first.checkoutTime, testUpdatedParkingModel.checkoutTime);
      expect(listResult.first.parkingTimeHours, 24);

      await db.close();
    });
  });
}

Future<Database> createDatabase() async {
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath,
      options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute(testQueryCreateTable);
          }));
  return db;
}
