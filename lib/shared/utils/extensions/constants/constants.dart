const String parkingTable = 'parking_tb';

const String queryOcuppied = '''
        SELECT * FROM $parkingTable
        WHERE checkinTime IS NOT NULL
        AND checkoutTime IS NULL
    ''';

String queryHistory(String dateSearch) => '''
        SELECT id, plate, checkinTime, checkoutTime, vacancy, 
          (julianday(checkoutTime) - julianday(checkinTime)) * 24 AS parkingTimeHours
        FROM $parkingTable
        WHERE checkoutTime IS NOT NULL
        AND DATE(checkoutTime) = '$dateSearch';
    ''';
