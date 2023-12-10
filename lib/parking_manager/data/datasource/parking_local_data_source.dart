import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';

abstract class ParkingLocalDataSource {
  Future<bool> initDb();
  Future<List<ParkingEntity>> getParking();
  Future<List<ParkingEntity>> getParkingOccupied();
  Future<void> registerParking(ParkingEntity parkingEntity);
  Future<void> updateParking(ParkingEntity parkingEntity);
}
