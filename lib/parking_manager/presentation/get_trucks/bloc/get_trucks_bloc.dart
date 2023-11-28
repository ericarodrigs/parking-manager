import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_trucks_usecase.dart';
part 'get_trucks_event.dart';
part 'get_trucks_state.dart';
part 'get_trucks_bloc.freezed.dart';

class GetTrucksBloc extends Bloc<GetTrucksEvent, GetTrucksState> {
  final GetTrucksUseCase getTrucksUseCase;

  GetTrucksBloc({
    required this.getTrucksUseCase,
  }) : super(const GetTrucksState.initial()) {
    on<GetTrucksEvent>((event, emit) async {
      if (event is GetAllTrucksEvent) {
        emit(const GetTrucksState.loading());
        final result = await getTrucksUseCase(
          NoParams(),
        );
        result.fold(
          (l) => emit(
            const GetTrucksState.error(),
          ),
          (r) => emit(
            GetTrucksState.loaded(r),
          ),
        );
      }
    });
  }
}
