import 'package:flutter_test/flutter_test.dart';
import 'package:parking_manager/shared/utils/extensions/constants/constants.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void sqfliteTestInit() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  setUpAll(() {
    sqfliteTestInit();
  });
  test('initDb', () async {
    var databaseCreated = false;
    late Database db;
    try {
      db = await databaseFactory.openDatabase(inMemoryDatabasePath,
          options: OpenDatabaseOptions(
              version: 1,
              onCreate: (db, version) async {
                await db.execute('''
          CREATE TABLE $parkingTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          plate TEXT,
          checkinTime TEXT,
          checkoutTime TEXT NULL,
          vacancy INTEGER
          )
        ''');
              }));
      databaseCreated = true;
      return db;
    } catch (e) {
      databaseCreated = false;
    }

    expect(databaseCreated, true);
    expect(db.database.isOpen, true);

    await db.close();

    expect(db.database.isOpen, false);
  });
}
