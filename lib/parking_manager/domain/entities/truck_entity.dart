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
}
