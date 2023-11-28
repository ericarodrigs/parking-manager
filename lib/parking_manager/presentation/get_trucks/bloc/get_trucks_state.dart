part of 'get_trucks_bloc.dart';

@freezed
class GetTrucksState with _$GetTrucksState {
  const factory GetTrucksState.initial() = _Initial;
  const factory GetTrucksState.loading() = _Loading;
  const factory GetTrucksState.loaded(List<TruckEntity> trucks) = _Loaded;
  const factory GetTrucksState.error() = _Failed;
}
