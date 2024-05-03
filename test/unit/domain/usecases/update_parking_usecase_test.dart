import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/update_parking_usecase.dart';
import 'package:parking_manager/shared/errors/failure.dart';

import '../../mocks/mocks.dart';
import 'update_parking_usecase_test.mocks.dart';

@GenerateMocks([ParkingRepository])
void main() {
  ParkingRepository mockParkingRepository = MockParkingRepository();
  UpdateParkingUseCase usecase =
      UpdateParkingUseCase(repository: mockParkingRepository);

  test('should update an object already registered', () async {
    when(mockParkingRepository.updateParking(testParkingEntity))
        .thenAnswer((_) => Future.value(const Right(null)));
    final result =
        await usecase(const Params(parkingEntity: testParkingEntity));
    expect(result, const Right(null));
    verify(mockParkingRepository.updateParking(testParkingEntity));
    verifyNoMoreInteractions(mockParkingRepository);
  });

  test('should return failure when call repository', () async {
    when(mockParkingRepository.updateParking(testParkingEntity))
        .thenAnswer((_) => Future.value(Left(DatabaseFailure())));
    final result =
        await usecase(const Params(parkingEntity: testParkingEntity));
    expect(result, Left(DatabaseFailure()));
    verify(mockParkingRepository.updateParking(testParkingEntity));
    verifyNoMoreInteractions(mockParkingRepository);
  });

  group('Params', () {
    test('Should return true when comparing two equal instances', () {
      const params1 = Params(parkingEntity: testParkingEntity);
      const params2 = Params(parkingEntity: testParkingEntity);
      final result = params1 == params2;
      expect(result, isTrue);
    });

    test(
        'Should return false when comparing two instances with different attributes',
        () {
      const params1 = Params(parkingEntity: testParkingEntity);
      const params2 = Params(
        parkingEntity: ParkingEntity(
          plate: 'plate',
          checkinTime: 'checkinTime',
          vacancy: 8,
        ),
      );
      final result = params1 == params2;
      expect(result, isFalse);
    });
  });
}
