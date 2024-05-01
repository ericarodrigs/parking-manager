import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_parking_occupied_usecase.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking_occupied/bloc/get_parking_occupied_bloc.dart';

import '../../../domain/usecases/get_parking_occupied_usecase_test.mocks.dart';
import '../../../mocks/mocks.dart';

@GenerateMocks([ParkingRepository])
void main() {
  ParkingRepository repository = MockParkingRepository();
  GetParkingOccupiedUseCase getParkingOccupiedUseCase =
      GetParkingOccupiedUseCase(repository: repository);
  GetParkingOccupiedBloc bloc = GetParkingOccupiedBloc(
      getParkingOccupiedUseCase: getParkingOccupiedUseCase);

  group('Bloc Test', () {
    test('Success', () async {
      when(repository.getParkingOccupied())
          .thenAnswer((_) => Future.value(const Right(testParkingEntityList)));

      bloc.add(const GetAllParkingOccupiedEvent());
      await expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const GetParkingOccupiedState.loading(),
            const GetParkingOccupiedState.loaded(testParkingEntityList),
          ],
        ),
      );
    });
  });
}
