import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_history_usecase.dart';
import 'package:parking_manager/parking_manager/presentation/get_history/bloc/get_history_bloc.dart';
import 'package:parking_manager/shared/errors/failure.dart';

import '../../../domain/usecases/get_history_usecase_test.mocks.dart';
import '../../../mocks/mocks.dart';

@GenerateMocks([ParkingRepository])
void main() {
  ParkingRepository repository = MockParkingRepository();
  GetHistoryUseCase getHistoryUseCase =
      GetHistoryUseCase(repository: repository);
  GetHistoryBloc bloc = GetHistoryBloc(getHistoryUseCase: getHistoryUseCase);

  group('Bloc Test - getHistory', () {
    test('Success - getHistory', () async {
      when(repository.getHistory(testDateSearch))
          .thenAnswer((_) => Future.value(const Right(testParkingEntityList)));

      bloc.add(const GetAllHistoryEvent(testDateSearch));
      await expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const GetHistoryState.loading(),
            const GetHistoryState.loaded(testParkingEntityList),
          ],
        ),
      );
    });

    test('Failure - getHistory', () async {
      when(repository.getHistory(testDateSearch))
          .thenAnswer((_) => Future.value(Left(NoDataFailure())));

      bloc.add(const GetAllHistoryEvent(testDateSearch));
      await expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const GetHistoryState.loading(),
            const GetHistoryState.error(),
          ],
        ),
      );
    });
  });
}
