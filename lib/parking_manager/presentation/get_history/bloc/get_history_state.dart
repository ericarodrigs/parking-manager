part of 'get_history_bloc.dart';

@freezed
class GetHistoryState with _$GetHistoryState {
  const factory GetHistoryState.initial() = _Initial;
  const factory GetHistoryState.loading() = _Loading;
  const factory GetHistoryState.loaded(List<ParkingEntity> parking) = _Loaded;
  const factory GetHistoryState.error() = _Failed;
}
