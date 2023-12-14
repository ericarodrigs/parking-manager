import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/usecases/register_parking_usecase.dart';
part 'register_parking_event.dart';
part 'register_parking_state.dart';
part 'register_parking_bloc.freezed.dart';

class RegisterParkingBloc
    extends Bloc<RegisterParkingEvent, RegisterParkingState> {
  final RegisterParkingUseCase registerParkingUseCase;

  RegisterParkingBloc({
    required this.registerParkingUseCase,
  }) : super(const RegisterParkingState.initial()) {
    on<RegisterParkingEvent>((event, emit) async {
      if (event is RegisterNewParkingEvent) {
        emit(const RegisterParkingState.loading());
        final result = await registerParkingUseCase(
          Params(parkingEntity: event.parkingEntity),
        );
        result.fold(
          (l) => emit(
            const RegisterParkingState.failed(),
          ),
          (r) => emit(
            const RegisterParkingState.success(),
          ),
        );
      }
    });
  }
}
