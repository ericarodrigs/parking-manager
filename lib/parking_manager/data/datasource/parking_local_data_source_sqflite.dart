import 'dart:io';

import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/shared/exceptions.dart';

class ParkingLocalDataSourceSqflite implements ParkingLocalDataSource {
  late Database _db;
  final _dbName = 'nsqflite.db';
  final _parkingTable = 'parking_tb';

  @override
  Future<bool> initDb() async {
    try {
      final dbFolder = await getDatabasesPath();
      if (!await Directory(dbFolder).exists()) {
        await Directory(dbFolder).create(recursive: true);
      }
      final dbPath = join(dbFolder, _dbName);
      _db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await _initParkingTable(db);
        },
      );
      return true;
    } catch (_) {
      throw ConnectionException();
    }
  }

  Future<void> _initParkingTable(Database db) async {
    String query = '''
          CREATE TABLE $_parkingTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          plate TEXT,
          checkinTime TEXT,
          checkoutTime TEXT NULL,
          vacancy INTEGER,
          isOpen BOOLEAN DEFAULT 1
          )
        ''';

    await db.execute(query);
  }

  @override
  Future<void> registerParking(ParkingEntity parkingEntity) async {
    try {
      await _db.insert(_parkingTable, parkingEntity.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw ConnectionException();
    }
  }

  @override
  Future<List<ParkingEntity>> getHistory(String dateSearch) async {
    String query = '''
    SELECT id, plate, checkinTime, checkoutTime, vacancy, isOpen, 
      (julianday(checkoutTime) - julianday(checkinTime)) * 24 AS parkingTimeHours
    FROM $_parkingTable
    WHERE checkoutTime IS NOT NULL
    AND isOpen = 1
    AND DATE(checkoutTime) = '$dateSearch';
  ''';

    List<Map<String, dynamic>> result = await _db.rawQuery(query);
    return result
        .map<ParkingEntity>((parking) => ParkingEntity.fromMap(parking))
        .toList();
  }

  @override
  Future<List<ParkingEntity>> getParkingOccupied() async {
    String query = 'SELECT * FROM $_parkingTable WHERE isOpen = 0';

    final response = await _db.rawQuery(query);
    return response
        .map<ParkingEntity>((parking) => ParkingEntity.fromMap(parking))
        .toList();
  }

  @override
  Future<void> updateParking(ParkingEntity parkingEntity) async {
    try {
      await _db.update(
        _parkingTable,
        parkingEntity.toMap(),
        where: 'id = ?',
        whereArgs: [parkingEntity.id],
      );
    } catch (e) {
      throw ConnectionException();
    }
  }
}
