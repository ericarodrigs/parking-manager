import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';

class ParkingModel extends ParkingEntity {
  const ParkingModel({
    super.id,
    required super.plate,
    required super.checkinTime,
    required super.vacancy,
    super.checkoutTime,
    super.parkingTimeHours,
    super.parkingCost,
  });

  factory ParkingModel.fromEntity(ParkingEntity parkingEntity) {
    return ParkingModel(
      id: parkingEntity.id,
      plate: parkingEntity.plate,
      checkinTime: parkingEntity.checkinTime,
      vacancy: parkingEntity.vacancy,
      checkoutTime: parkingEntity.checkoutTime,
    );
  }

  factory ParkingModel.fromMap(Map<String, dynamic> map) {
    return ParkingModel(
      id: map['id'],
      plate: map['plate'],
      checkinTime: map['checkinTime'],
      checkoutTime: map['checkoutTime'],
      parkingTimeHours: map['parkingTimeHours'],
      vacancy: map['vacancy'],
      parkingCost: map['parkingTimeHours'] != null
          ? (map['parkingTimeHours']).ceil() * 10.0
          : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'plate': plate,
      'checkinTime': checkinTime,
      'vacancy': vacancy,
    };

    if (checkoutTime != null && checkoutTime!.isNotEmpty) {
      map['checkoutTime'] = checkoutTime;
    }

    return map;
  }

  @override
  String toString() {
    return 'ParkingModel {id: $id, plate: $plate, checkinTime: $checkinTime, checkoutTime: $checkoutTime, vacancy: $vacancy, parkingTimeHours: $parkingTimeHours, parkingCost: $parkingCost}';
  }
}
