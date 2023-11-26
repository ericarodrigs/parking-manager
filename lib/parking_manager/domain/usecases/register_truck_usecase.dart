import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_manager/parking_manager/data/models/truck_model.dart';
import 'package:parking_manager/parking_manager/domain/repositories/truck_repository.dart';
import 'package:parking_manager/shared/failure.dart';
import 'package:parking_manager/shared/usecases.dart';

class RegisterTruckUseCase implements Usecases<bool, Params> {
  final TruckRepository repository;

  RegisterTruckUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.registerTruck(params.truckModel);
  }
}

class Params extends Equatable {
  final TruckModel truckModel;

  const Params({
    required this.truckModel,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
