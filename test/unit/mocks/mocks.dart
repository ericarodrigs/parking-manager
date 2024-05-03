import 'package:parking_manager/parking_manager/data/models/parking_model.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/shared/utils/constants/constants.dart';

const List<ParkingModel> testParkingModelList = [
  ParkingModel(
    plate: 'ABC1234',
    checkinTime: '2023-12-13 22:56:17',
    vacancy: 3,
    parkingCost: 0.0,
  )
];

const ParkingModel testParkingModel = ParkingModel(
  plate: 'ABC1234',
  checkinTime: '2023-12-13 22:56:17',
  vacancy: 3,
  parkingCost: 0.0,
);

const ParkingModel testInsertedParkingModel = ParkingModel(
  plate: 'ABC1234',
  checkinTime: '2023-12-13 22:56:17',
  vacancy: 3,
  parkingCost: 0.0,
  id: 1,
);

const ParkingModel testUpdatedParkingModel = ParkingModel(
  plate: 'ABC1234',
  checkinTime: '2023-12-13 22:56:17',
  checkoutTime: '2023-12-14 22:56:17',
  vacancy: 3,
  parkingCost: 0.0,
  id: 1,
);

const List<ParkingEntity> testParkingEntityList = [
  ParkingEntity(
    plate: 'ABC1234',
    checkinTime: '2023-12-13 22:56:17',
    vacancy: 3,
    parkingCost: 0.0,
  )
];

const ParkingEntity testParkingEntity = ParkingEntity(
  plate: 'ABC1234',
  checkinTime: '2023-12-13 22:56:17',
  vacancy: 3,
  parkingCost: 0.0,
);

const String testDateSearch = '2023-12-13';

const String testQueryCreateTable = '''
          CREATE TABLE $parkingTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          plate TEXT,
          checkinTime TEXT,
          checkoutTime TEXT NULL,
          vacancy INTEGER
          )
        ''';
