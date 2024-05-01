import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/shared/errors/failure.dart';
import 'package:parking_manager/shared/usecase/usecases.dart';

class GetHistoryUseCase implements Usecases<List<ParkingEntity>, Params> {
  final ParkingRepository repository;

  GetHistoryUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<ParkingEntity>>> call(Params params) async {
    return await repository.getHistory(params.dateSearch);
  }
}

class Params extends Equatable {
  final String dateSearch;

  const Params({
    required this.dateSearch,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
