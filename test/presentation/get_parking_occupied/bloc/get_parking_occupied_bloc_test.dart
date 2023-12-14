import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_parking_occupied_usecase.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking_occupied/bloc/get_parking_occupied_bloc.dart';

import '../../../domain/usecases/get_parking_occupied_usecase_test.mocks.dart';

@GenerateMocks([ParkingRepository])
void main() {
  ParkingRepository repository = MockParkingRepository();
  GetParkingOccupiedUseCase getParkingOccupiedUseCase =
      GetParkingOccupiedUseCase(repository: repository);
  GetParkingOccupiedBloc bloc = GetParkingOccupiedBloc(
      getParkingOccupiedUseCase: getParkingOccupiedUseCase);

  group('Bloc Test', () {
    test('Success', () async {
      final List<ParkingEntity> testParkingEntityList = [
        ParkingEntity(
          plate: 'ABC1234',
          checkinTime: '2023-12-13 22:56:17',
          vacancy: 3,
          isOpen: false,
          parkingCost: 0.0,
        )
      ];

      when(repository.getParkingOccupied())
          .thenAnswer((_) => Future.value(Right(testParkingEntityList)));

      bloc.add(const GetAllParkingOccupiedEvent());
      await expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const GetParkingOccupiedState.loading(),
            GetParkingOccupiedState.loaded(testParkingEntityList),
          ],
        ),
      );
    });
  });
}
