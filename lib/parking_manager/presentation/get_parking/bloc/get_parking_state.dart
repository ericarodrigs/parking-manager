part of 'get_parking_bloc.dart';

@freezed
class GetParkingState with _$GetParkingState {
  const factory GetParkingState.initial() = _Initial;
  const factory GetParkingState.loading() = _Loading;
  const factory GetParkingState.loaded(List<ParkingEntity> parking) = _Loaded;
  const factory GetParkingState.error() = _Failed;
}
