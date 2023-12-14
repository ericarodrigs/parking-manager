import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/usecases/update_parking_usecase.dart';
part 'update_parking_event.dart';
part 'update_parking_state.dart';
part 'update_parking_bloc.freezed.dart';

class UpdateParkingBloc extends Bloc<UpdateParkingEvent, UpdateParkingState> {
  final UpdateParkingUseCase updateParkingUseCase;

  UpdateParkingBloc({
    required this.updateParkingUseCase,
  }) : super(const UpdateParkingState.initial()) {
    on<UpdateParkingEvent>((event, emit) async {
      if (event is UpdateNewParkingEvent) {
        emit(const UpdateParkingState.loading());
        final result = await updateParkingUseCase(
          Params(parkingEntity: event.parkingEntity),
        );
        result.fold(
          (l) => emit(
            const UpdateParkingState.failed(),
          ),
          (r) => emit(
            const UpdateParkingState.success(),
          ),
        );
      }
    });
  }
}
