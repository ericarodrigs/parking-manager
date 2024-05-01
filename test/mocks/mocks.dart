import 'package:parking_manager/parking_manager/data/models/parking_model.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';

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

const List<ParkingEntity> testParkingEntityList = [
  ParkingEntity(
    plate: 'ABC1234',
    checkinTime: '2023-12-13 22:56:17',
    vacancy: 3,
    parkingCost: 0.0,
  )
];
