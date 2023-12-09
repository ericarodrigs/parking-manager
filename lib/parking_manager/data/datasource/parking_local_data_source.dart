import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';

abstract class ParkingLocalDataSource {
  Future<bool> initDb();
  Future<List<ParkingEntity>> getParking();
  Future<bool> registerParking(ParkingEntity parkingEntity);
  Future<bool> updateParking(ParkingEntity parkingEntity);
  Future<bool> deleteParking(String id);
}
