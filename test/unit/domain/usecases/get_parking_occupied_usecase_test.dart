import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_parking_occupied_usecase.dart';
import 'package:parking_manager/shared/errors/failure.dart';

import '../../mocks/mocks.dart';
import 'get_parking_occupied_usecase_test.mocks.dart';

@GenerateMocks([ParkingRepository])
void main() {
  ParkingRepository mockParkingRepository = MockParkingRepository();
  GetParkingOccupiedUseCase usecase =
      GetParkingOccupiedUseCase(repository: mockParkingRepository);

  test('should get the list of objects that are registered', () async {
    when(mockParkingRepository.getParkingOccupied())
        .thenAnswer((_) => Future.value(const Right(testParkingEntityList)));
    final result = await usecase(NoParams());
    expect(result.fold((l) => l, (r) => r), testParkingEntityList);
    verify(mockParkingRepository.getParkingOccupied());
    verifyNoMoreInteractions(mockParkingRepository);
  });

  test('should return failure when call repository', () async {
    when(mockParkingRepository.getParkingOccupied())
        .thenAnswer((_) => Future.value(Left(NoDataFailure())));
    final result = await usecase(NoParams());
    expect(result.fold((l) => l, (r) => r), NoDataFailure());
    verify(mockParkingRepository.getParkingOccupied());
    verifyNoMoreInteractions(mockParkingRepository);
  });

  group('Params', () {
    test('Should return true when comparing two equal instances', () {
      final params1 = NoParams();
      final params2 = NoParams();
      final result = params1 == params2;
      expect(result, isTrue);
    });

    test('Should have equal props lists for equal instances', () {
      final params1 = NoParams();
      final params2 = NoParams();
      expect(params1.props, equals(params2.props));
    });
  });
}
