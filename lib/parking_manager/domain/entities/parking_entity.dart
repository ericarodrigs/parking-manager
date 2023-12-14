class ParkingEntity {
  final int? id;
  final String plate;
  final String checkinTime;
  final String? checkoutTime;
  final int vacancy;
  bool isOpen;
  double? parkingTimeHours;
  double? parkingCost;

  ParkingEntity({
    this.id,
    required this.plate,
    required this.checkinTime,
    required this.vacancy,
    this.checkoutTime,
    this.isOpen = true,
    this.parkingTimeHours,
    this.parkingCost,
  });

  factory ParkingEntity.fromMap(Map<String, dynamic> map) {
    return ParkingEntity(
      id: map['id'],
      plate: map['plate'],
      checkinTime: map['checkinTime'],
      checkoutTime: map['checkoutTime'],
      parkingTimeHours: map['parkingTimeHours'],
      vacancy: map['vacancy'],
      isOpen: map['isOpen'] == 1,
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
    if (parkingTimeHours != null) {
      map['parkingCost'] = parkingTimeHours;
    }

    isOpen = (checkoutTime != null && checkoutTime!.isNotEmpty) ? true : false;
    map['isOpen'] = isOpen ? 1 : 0;
    return map;
  }

  @override
  String toString() {
    return 'ParkingEntity {id: $id, plate: $plate, checkinTime: $checkinTime, checkoutTime: $checkoutTime, vacancy: $vacancy, isOpen: $isOpen, parkingTimeHours: $parkingTimeHours}, parkingCost: $parkingCost';
  }
}
