import 'dart:io';

import 'package:parking_manager/shared/errors/exceptions.dart';
import 'package:parking_manager/shared/utils/constants/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ParkingDatabaseInitializer {
  final dbName = 'nsqflite.db';

  Future<Database> initDb() async {
    try {
      final dbFolder = await getDatabasesPath();
      if (!await Directory(dbFolder).exists()) {
        await Directory(dbFolder).create(recursive: true);
      }
      final dbPath = join(dbFolder, dbName);
      final Database database = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await _initParkingTable(db);
        },
      );
      return database;
    } catch (_) {
      throw ConnectionException();
    }
  }

  Future<void> _initParkingTable(Database db) async {
    String query = '''
          CREATE TABLE $parkingTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            plate TEXT,
            checkinTime TEXT,
            checkoutTime TEXT NULL,
            vacancy INTEGER
          )
        ''';
    await db.execute(query);
  }
}
