import 'package:parking_manager/parking_manager/data/models/truck_model.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';

abstract class TruckLocalDataSource {
  Future<bool> initDb();
  Future<List<TruckEntity>> getTrucks();
  Future<bool> registerTruck(TruckModel truckModel);
  Future<bool> updateTruck(TruckModel truckModel);
  Future<bool> deleteTruck(String id);
}
