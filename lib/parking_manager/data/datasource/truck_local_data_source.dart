import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';

abstract class TruckLocalDataSource {
  Future<bool> initDb();
  Future<List<TruckEntity>> getTrucks();
  Future<bool> registerTruck(TruckEntity truckEntity);
  Future<bool> updateTruck(TruckEntity truckEntity);
  Future<bool> deleteTruck(String id);
}
