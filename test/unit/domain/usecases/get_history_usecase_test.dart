import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_history_usecase.dart';
import 'package:parking_manager/shared/errors/failure.dart';

import '../../mocks/mocks.dart';
import 'get_parking_occupied_usecase_test.mocks.dart';

@GenerateMocks([ParkingRepository])
void main() {
  ParkingRepository mockParkingRepository = MockParkingRepository();
  GetHistoryUseCase usecase =
      GetHistoryUseCase(repository: mockParkingRepository);

  test('should get the list of objects that are registered in a given date',
      () async {
    when(mockParkingRepository.getHistory(testDateSearch))
        .thenAnswer((_) => Future.value(const Right(testParkingEntityList)));
    final result = await usecase(const Params(dateSearch: testDateSearch));
    expect(result.fold((l) => l, (r) => r), testParkingEntityList);
    verify(mockParkingRepository.getHistory(testDateSearch));
    verifyNoMoreInteractions(mockParkingRepository);
  });

  test('should return failure when call repository', () async {
    when(mockParkingRepository.getHistory(testDateSearch))
        .thenAnswer((_) => Future.value(Left(NoDataFailure())));
    final result = await usecase(const Params(dateSearch: testDateSearch));
    expect(result.fold((l) => l, (r) => r), NoDataFailure());
    verify(mockParkingRepository.getHistory(testDateSearch));
    verifyNoMoreInteractions(mockParkingRepository);
  });

  group('Params', () {
    test('Should return true when comparing two equal instances', () {
      const params1 = Params(dateSearch: testDateSearch);
      const params2 = Params(dateSearch: testDateSearch);
      final result = params1 == params2;
      expect(result, isTrue);
    });

    test(
        'Should return false when comparing two instances with different attributes',
        () {
      const params1 = Params(dateSearch: testDateSearch);
      const params2 = Params(dateSearch: '2023-12-14');
      final result = params1 == params2;
      expect(result, isFalse);
    });
  });
}
