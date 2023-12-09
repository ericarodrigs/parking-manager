import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_parking_usecase.dart';
part 'get_parking_event.dart';
part 'get_parking_state.dart';
part 'get_parking_bloc.freezed.dart';

class GetParkingBloc extends Bloc<GetParkingEvent, GetParkingState> {
  final GetParkingUseCase getParkingUseCase;

  GetParkingBloc({
    required this.getParkingUseCase,
  }) : super(const GetParkingState.initial()) {
    on<GetParkingEvent>((event, emit) async {
      if (event is GetAllParkingEvent) {
        emit(const GetParkingState.loading());
        final result = await getParkingUseCase(
          NoParams(),
        );
        result.fold(
          (l) => emit(
            const GetParkingState.error(),
          ),
          (r) => emit(
            GetParkingState.loaded(r),
          ),
        );
      }
    });
  }
}
