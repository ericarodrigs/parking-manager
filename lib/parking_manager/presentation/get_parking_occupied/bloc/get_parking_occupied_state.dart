part of 'get_parking_occupied_bloc.dart';

@freezed
class GetParkingOccupiedState with _$GetParkingOccupiedState {
  const factory GetParkingOccupiedState.initial() = _Initial;
  const factory GetParkingOccupiedState.loading() = _Loading;
  const factory GetParkingOccupiedState.loaded(List<ParkingEntity> parking) =
      _Loaded;
  const factory GetParkingOccupiedState.error() = _Failed;
}
