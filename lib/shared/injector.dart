import 'package:get_it/get_it.dart';
import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source.dart';
import 'package:parking_manager/parking_manager/data/datasource/parking_local_data_source_sqflite.dart';
import 'package:parking_manager/parking_manager/data/repositories/parking_repository_impl.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_parking_usecase.dart';
import 'package:parking_manager/parking_manager/domain/usecases/register_parking_usecase.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking/bloc/get_parking_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/register_parking/bloc/register_parking_bloc.dart';

final injector = GetIt.instance;

Future<void> initDependencies() async {
  /// Data Source ///
  injector.registerLazySingleton<ParkingLocalDataSource>(
      () => ParkingLocalDataSourceSqflite());

  /// Repository ///
  injector.registerLazySingleton<ParkingRepository>(
      () => ParkingRepositoryImpl(parkingLocalDataSource: injector()));

  /// UseCase ///
  injector
      .registerLazySingleton(() => GetParkingUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => RegisterParkingUseCase(repository: injector()));
  // injector.registerLazySingleton(() => UpdateParking(repository: injector()));
  // injector.registerLazySingleton(() => DeleteParking(repository: injector()));

  /// BloC ///
  injector.registerFactory(
      () => RegisterParkingBloc(registerParkingUseCase: injector()));
  injector.registerFactory(() => GetParkingBloc(getParkingUseCase: injector()));

  await injector<ParkingLocalDataSource>().initDb();
}
