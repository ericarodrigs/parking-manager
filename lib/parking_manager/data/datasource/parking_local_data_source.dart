import 'package:parking_manager/parking_manager/data/models/parking_model.dart';

abstract class ParkingLocalDataSource {
  Future<List<ParkingModel>> getHistory(String dateSearch);
  Future<List<ParkingModel>> getParkingOccupied();
  Future<void> registerParking(ParkingModel parkingModel);
  Future<void> updateParking(ParkingModel parkingModel);
}
