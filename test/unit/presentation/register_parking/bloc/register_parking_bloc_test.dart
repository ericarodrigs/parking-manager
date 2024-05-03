import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart';
import 'package:parking_manager/parking_manager/domain/usecases/register_parking_usecase.dart';
import 'package:parking_manager/parking_manager/presentation/register_parking/bloc/register_parking_bloc.dart';
import 'package:parking_manager/shared/errors/failure.dart';

import '../../../domain/usecases/register_parking_usecase_test.mocks.dart';
import '../../../mocks/mocks.dart';

@GenerateMocks([ParkingRepository])
void main() {
  ParkingRepository repository = MockParkingRepository();
  RegisterParkingUseCase registerParkingUseCase =
      RegisterParkingUseCase(repository: repository);
  RegisterParkingBloc bloc =
      RegisterParkingBloc(registerParkingUseCase: registerParkingUseCase);

  group('Bloc Test - registerParking', () {
    test('Success - registerParking', () async {
      when(repository.registerParking(testParkingEntity))
          .thenAnswer((_) => Future.value(const Right(null)));

      bloc.add(const RegisterNewParkingEvent(testParkingEntity));
      await expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const RegisterParkingState.loading(),
            const RegisterParkingState.success(),
          ],
        ),
      );
    });

    test('Failure - registerParking', () async {
      when(repository.registerParking(testParkingEntity))
          .thenAnswer((_) => Future.value(Left(DatabaseFailure())));

      bloc.add(const RegisterNewParkingEvent(testParkingEntity));
      await expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const RegisterParkingState.loading(),
            const RegisterParkingState.failed(),
          ],
        ),
      );
    });
  });
}
