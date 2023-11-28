import 'package:get_it/get_it.dart';
import 'package:parking_manager/parking_manager/data/datasource/truck_local_data_source.dart';
import 'package:parking_manager/parking_manager/data/datasource/truck_local_data_source_sqflite.dart';
import 'package:parking_manager/parking_manager/data/repositories/truck_repository_impl.dart';
import 'package:parking_manager/parking_manager/domain/repositories/truck_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_trucks_usecase.dart';
import 'package:parking_manager/parking_manager/domain/usecases/register_truck_usecase.dart';
import 'package:parking_manager/parking_manager/presentation/get_trucks/bloc/get_trucks_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/register_truck/bloc/register_truck_bloc.dart';

final injector = GetIt.instance;

Future<void> initDependencies() async {
  /// Data Source ///
  injector.registerLazySingleton<TruckLocalDataSource>(
      () => TruckLocalDataSourceSqflite());

  /// Repository ///
  injector.registerLazySingleton<TruckRepository>(
      () => TruckRepositoryImpl(truckLocalDataSource: injector()));

  /// UseCase ///
  injector
      .registerLazySingleton(() => GetTrucksUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => RegisterTruckUseCase(repository: injector()));
  // injector.registerLazySingleton(() => UpdateTruck(repository: injector()));
  // injector.registerLazySingleton(() => DeleteTruck(repository: injector()));

  /// BloC ///
  injector.registerFactory(
      () => RegisterTruckBloc(registerTruckUseCase: injector()));
  injector.registerFactory(() => GetTrucksBloc(getTrucksUseCase: injector()));

  await injector<TruckLocalDataSource>().initDb();
}
