import 'package:equatable/equatable.dart';

class ParkingEntity extends Equatable {
  final int? id;
  final String plate;
  final String checkinTime;
  final String? checkoutTime;
  final int vacancy;
  final double? parkingTimeHours;
  final double? parkingCost;

  const ParkingEntity({
    this.id,
    required this.plate,
    required this.checkinTime,
    required this.vacancy,
    this.checkoutTime,
    this.parkingTimeHours,
    this.parkingCost,
  });

  @override
  List<Object?> get props => [
        id,
        plate,
        checkinTime,
        checkoutTime,
        vacancy,
        parkingTimeHours,
        parkingCost,
      ];
}
