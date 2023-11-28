import 'package:bloc/bloc.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';
import 'package:parking_manager/parking_manager/domain/usecases/register_truck_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_truck_event.dart';
part 'register_truck_state.dart';
part 'register_truck_bloc.freezed.dart';

class RegisterTruckBloc extends Bloc<RegisterTruckEvent, RegisterTruckState> {
  final RegisterTruckUseCase registerTruckUseCase;

  RegisterTruckBloc({
    required this.registerTruckUseCase,
  }) : super(const RegisterTruckState.initial()) {
    on<RegisterTruckEvent>((event, emit) async {
      if (event is RegisterNewTruckEvent) {
        emit(const RegisterTruckState.loading());
        final result = await registerTruckUseCase(
          Params(truckEntity: event.truckEntity),
        );
        result.fold(
          (l) => emit(
            const RegisterTruckState.failed(),
          ),
          (r) => emit(
            const RegisterTruckState.success(),
          ),
        );
      }
    });
  }
}
