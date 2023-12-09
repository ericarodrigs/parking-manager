class ParkingEntity {
  final String? id;
  final String plate;
  final String checkinTime;
  final String checkoutTime;
  final int vacancy;

  ParkingEntity({
    this.id,
    required this.plate,
    required this.checkinTime,
    required this.checkoutTime,
    required this.vacancy,
  });

  factory ParkingEntity.fromMap(Map<String, dynamic> map) {
    return ParkingEntity(
      id: map['id'],
      plate: map['plate'],
      checkinTime: map['checkinTime'],
      checkoutTime: map['checkoutTime'],
      vacancy: map['vacancy'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plate': plate,
      'checkinTime': checkinTime,
      'checkoutTime': checkoutTime,
      'vacancy': vacancy,
    };
  }

  @override
  String toString() {
    return 'ParkingEntity {id: $id, plate: $plate, checkinTime: $checkinTime, checkoutTime: $checkoutTime, vacancy: $vacancy}';
  }
}
