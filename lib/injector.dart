import 'package:get_it/get_it.dart';
import 'package:parking_manager/parking_manager/data/datasource/config_database/parking_database_initializer.dart';
import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source.dart';
import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source_sqflite.dart';
import 'package:parking_manager/parking_manager/data/repositories/parking_repository_impl.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_history_usecase.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_parking_occupied_usecase.dart';
import 'package:parking_manager/parking_manager/domain/usecases/register_parking_usecase.dart';
import 'package:parking_manager/parking_manager/domain/usecases/update_parking_usecase.dart';
import 'package:parking_manager/parking_manager/presentation/get_history/bloc/get_history_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking_occupied/bloc/get_parking_occupied_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/register_parking/bloc/register_parking_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/update_parking/bloc/update_parking_bloc.dart';
import 'package:sqflite/sqflite.dart';

final injector = GetIt.instance;

Future<void> initDependencies() async {
  /// Database ///
  injector.registerSingleton<ParkingDatabaseInitializer>(
      ParkingDatabaseInitializer());

  final Database database =
      await injector<ParkingDatabaseInitializer>().initDb();

  /// Data Source ///
  injector.registerLazySingleton<ParkingLocalDataSource>(
      () => ParkingLocalDataSourceSqflite(database: database));

  /// Repository ///
  injector.registerLazySingleton<ParkingRepository>(
      () => ParkingRepositoryImpl(parkingLocalDataSource: injector()));

  /// UseCase ///
  injector
      .registerLazySingleton(() => GetHistoryUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => GetParkingOccupiedUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => RegisterParkingUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => UpdateParkingUseCase(repository: injector()));

  /// BloC ///
  injector.registerFactory(
      () => RegisterParkingBloc(registerParkingUseCase: injector()));
  injector.registerFactory(() => GetHistoryBloc(getHistoryUseCase: injector()));
  injector.registerFactory(
      () => GetParkingOccupiedBloc(getParkingOccupiedUseCase: injector()));
  injector.registerFactory(
      () => UpdateParkingBloc(updateParkingUseCase: injector()));
}
