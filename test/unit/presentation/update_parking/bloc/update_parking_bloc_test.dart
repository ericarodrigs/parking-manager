import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/update_parking_usecase.dart';
import 'package:parking_manager/parking_manager/presentation/update_parking/bloc/update_parking_bloc.dart';
import 'package:parking_manager/shared/errors/failure.dart';

import '../../../mocks/mocks.dart';
import '../../../domain/usecases/update_parking_usecase_test.mocks.dart';

@GenerateMocks([ParkingRepository])
void main() {
  ParkingRepository repository = MockParkingRepository();
  UpdateParkingUseCase updateParkingUseCase =
      UpdateParkingUseCase(repository: repository);
  UpdateParkingBloc bloc =
      UpdateParkingBloc(updateParkingUseCase: updateParkingUseCase);

  group('Bloc Test - updateParking', () {
    test('Success - updateParking', () async {
      when(repository.updateParking(testParkingEntity))
          .thenAnswer((_) => Future.value(const Right(null)));

      bloc.add(const UpdateNewParkingEvent(testParkingEntity));
      await expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const UpdateParkingState.loading(),
            const UpdateParkingState.success(),
          ],
        ),
      );
    });

    test('Failure - updateParking', () async {
      when(repository.updateParking(testParkingEntity))
          .thenAnswer((_) => Future.value(Left(DatabaseFailure())));

      bloc.add(const UpdateNewParkingEvent(testParkingEntity));
      await expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const UpdateParkingState.loading(),
            const UpdateParkingState.failed(),
          ],
        ),
      );
    });
  });
}
