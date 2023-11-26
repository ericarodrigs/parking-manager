import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';

class TruckModel extends TruckEntity {
  TruckModel({
    String? id,
    String? plate,
    DateTime? checkinTime,
    DateTime? checkoutTime,
    int? vacancy,
    String? driver,
    double? checkoutValue,
  }) : super(
          id: id,
          plate: plate,
          checkinTime: checkinTime,
          checkoutTime: checkoutTime,
          vacancy: vacancy,
          driver: driver,
          checkoutValue: checkoutValue,
        );

  factory TruckModel.fromMap(Map<String, dynamic> map) {
    return TruckModel(
      id: map['id'],
      plate: map['plate'],
      checkinTime: map['checkinTime'] as DateTime,
      checkoutTime: map['checkoutTime'] as DateTime,
      vacancy: map['vacancy'] as int,
      driver: map['driver'],
      checkoutValue: map['checkoutValue'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plate': plate,
      'checkinTime': checkinTime,
      'checkoutTime': checkoutTime,
      'vacancy': vacancy,
      'driver': driver,
      'checkoutValue': checkoutValue,
    };
  }

  @override
  String toString() {
    return 'TruckModel {id: $id, plate: $plate, checkinTime: $checkinTime, checkoutTime: $checkoutTime, vacancy: $vacancy, driver: $driver, checkoutValue: $checkoutValue}';
  }
}
