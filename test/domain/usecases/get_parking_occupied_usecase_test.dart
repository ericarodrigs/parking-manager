import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_parking_occupied_usecase.dart';

import '../../mocks/mocks.dart';
import 'get_parking_occupied_usecase_test.mocks.dart';

@GenerateMocks([ParkingRepository])
void main() {
  ParkingRepository mockParkingRepository = MockParkingRepository();
  GetParkingOccupiedUseCase usecase =
      GetParkingOccupiedUseCase(repository: mockParkingRepository);

  test(
    'should get the list of objects that are registered',
    () async {
      //arrange
      when(mockParkingRepository.getParkingOccupied())
          .thenAnswer((_) => Future.value(const Right(testParkingEntityList)));
      //act
      final result = await usecase(NoParams());
      //assert
      expect(result.fold((l) => l, (r) => r), testParkingEntityList);
      verify(mockParkingRepository.getParkingOccupied());
      verifyNoMoreInteractions(mockParkingRepository);
    },
  );
}
