class TruckEntity {
  final String? id;
  final String? plate;
  final DateTime? checkinTime;
  final DateTime? checkoutTime;
  final String? vacancy;
  final String? driver;
  final double? checkoutValue;

  TruckEntity({
    this.id,
    this.plate,
    this.checkinTime,
    this.checkoutTime,
    this.vacancy,
    this.driver,
    this.checkoutValue,
  });

  factory TruckEntity.fromMap(Map<String, dynamic> map) {
    return TruckEntity(
      id: map['id'],
      plate: map['plate'],
      //checkinTime: map['checkinTime'] as DateTime,
      //checkoutTime: map['checkoutTime'] as DateTime,
      vacancy: map['vacancy'],
      driver: map['driver'],
      //checkoutValue: map['checkoutValue'] as double,
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
    return 'TruckEntity {id: $id, plate: $plate, checkinTime: $checkinTime, checkoutTime: $checkoutTime, vacancy: $vacancy, driver: $driver, checkoutValue: $checkoutValue}';
  }
}
