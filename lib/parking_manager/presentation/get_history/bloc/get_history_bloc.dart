import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/domain/usecases/get_history_usecase.dart';
part 'get_history_event.dart';
part 'get_history_state.dart';
part 'get_history_bloc.freezed.dart';

class GetHistoryBloc extends Bloc<GetHistoryEvent, GetHistoryState> {
  final GetHistoryUseCase getHistoryUseCase;

  GetHistoryBloc({
    required this.getHistoryUseCase,
  }) : super(const GetHistoryState.initial()) {
    on<GetHistoryEvent>((event, emit) async {
      if (event is GetAllHistoryEvent) {
        emit(const GetHistoryState.loading());
        final result = await getHistoryUseCase(
          NoParams(),
        );
        result.fold(
          (l) => emit(
            const GetHistoryState.error(),
          ),
          (r) => emit(
            GetHistoryState.loaded(r),
          ),
        );
      }
    });
  }
}
