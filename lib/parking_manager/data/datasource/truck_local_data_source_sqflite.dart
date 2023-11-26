import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:parking_manager/parking_manager/data/datasource/truck_local_data_source.dart';
import 'package:parking_manager/parking_manager/data/models/truck_model.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';
import 'package:parking_manager/shared/exceptions.dart';

class TruckLocalDataSourceSqflite implements TruckLocalDataSource {
  late Database _db;
  final _dbName = 'nsqflite.db';
  final _truckTable = 'truck_tb';

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
          await _initTruckTable(db);
        },
      );
      return true;
    } catch (_) {
      throw ConnectionException();
    }
  }

  Future<void> _initTruckTable(Database db) async {
    await db.execute('''
          CREATE TABLE $_truckTable(
          plate TEXT,
          driver TEXT
          )
        ''');
  }

  @override
  Future<bool> registerTruck(TruckModel truckModel) async {
    try {
      await _db.transaction(
        (txn) async {
          await txn.rawInsert('''
          INSERT INTO $_truckTable 
          (
          plate,
          driver
          )
          VALUES
            (
              "${truckModel.plate}",
              "${truckModel.driver}"
            )''');
        },
      );
      return Future.value(true);
    } catch (e) {
      throw ConnectionException();
    }
  }

  @override
  Future<bool> deleteTruck(String id) {
    // TODO: implement deleteTruck
    throw UnimplementedError();
  }

  @override
  Future<List<TruckEntity>> getTrucks() {
    // TODO: implement getTrucks
    throw UnimplementedError();
  }

  @override
  Future<bool> updateTruck(TruckModel truckModel) {
    // TODO: implement updateTruck
    throw UnimplementedError();
  }
}
