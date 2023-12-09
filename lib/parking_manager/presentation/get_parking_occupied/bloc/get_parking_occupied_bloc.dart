import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_parking_occupied_usecase.dart';
part 'get_parking_occupied_event.dart';
part 'get_parking_occupied_state.dart';
part 'get_parking_occupied_bloc.freezed.dart';

class GetParkingOccupiedBloc
    extends Bloc<GetParkingOccupiedEvent, GetParkingOccupiedState> {
  final GetParkingOccupiedUseCase getParkingOccupiedUseCase;

  GetParkingOccupiedBloc({
    required this.getParkingOccupiedUseCase,
  }) : super(const GetParkingOccupiedState.initial()) {
    on<GetParkingOccupiedEvent>((event, emit) async {
      if (event is GetAllParkingOccupiedEvent) {
        emit(const GetParkingOccupiedState.loading());
        final result = await getParkingOccupiedUseCase(
          NoParams(),
        );
        result.fold(
          (l) => emit(
            const GetParkingOccupiedState.error(),
          ),
          (r) => emit(
            GetParkingOccupiedState.loaded(r),
          ),
        );
      }
    });
  }
}
