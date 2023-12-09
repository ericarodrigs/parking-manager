class ParkingEntity {
  final int? id;
  final String plate;
  final int checkinTime;
  final int? checkoutTime;
  final int vacancy;
  bool isOpen;

  ParkingEntity({
    this.id,
    required this.plate,
    required this.checkinTime,
    required this.vacancy,
    this.checkoutTime,
    this.isOpen = true,
  });

  factory ParkingEntity.fromMap(Map<String, dynamic> map) {
    return ParkingEntity(
      id: map['id'],
      plate: map['plate'],
      checkinTime: map['checkinTime'],
      checkoutTime: map['checkoutTime'],
      vacancy: map['vacancy'],
      isOpen: map['isOpen'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'plate': plate,
      'checkinTime': checkinTime,
      'vacancy': vacancy,
    };

    if (checkoutTime != null) {
      map['checkoutTime'] = checkoutTime;
    }

    isOpen = checkoutTime != null ? true : false;
    map['isOpen'] = isOpen ? 1 : 0;
    print(map);
    return map;
  }

  @override
  String toString() {
    return 'ParkingEntity {id: $id, plate: $plate, checkinTime: $checkinTime, checkoutTime: $checkoutTime, vacancy: $vacancy, isOpen: $isOpen}';
  }
}
