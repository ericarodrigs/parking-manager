import 'package:parking_manager/shared/utils/constants/constants.dart';
import 'package:sqflite/sqflite.dart';

import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source.dart';
import 'package:parking_manager/parking_manager/data/models/parking_model.dart';
import 'package:parking_manager/shared/errors/exceptions.dart';

class ParkingLocalDataSourceSqflite implements ParkingLocalDataSource {
  final Database database;

  ParkingLocalDataSourceSqflite({
    required this.database,
  });

  @override
  Future<void> registerParking(ParkingModel parkingModel) async {
    try {
      await database.insert(parkingTable, parkingModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw ConnectionException();
    }
  }

  @override
  Future<List<ParkingModel>> getHistory(String dateSearch) async {
    List<Map<String, dynamic>> result =
        await database.rawQuery(queryHistory(dateSearch));
    return result
        .map<ParkingModel>((parking) => ParkingModel.fromMap(parking))
        .toList();
  }

  @override
  Future<List<ParkingModel>> getParkingOccupied() async {
    final response = await database.rawQuery(queryOcuppied);
    return response
        .map<ParkingModel>((parking) => ParkingModel.fromMap(parking))
        .toList();
  }

  @override
  Future<void> updateParking(ParkingModel parkingModel) async {
    try {
      await database.update(
        parkingTable,
        parkingModel.toMap(),
        where: 'id = ?',
        whereArgs: [parkingModel.id],
      );
    } catch (e) {
      throw ConnectionException();
    }
  }
}
