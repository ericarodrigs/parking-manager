part of 'update_parking_bloc.dart';

@freezed
class UpdateParkingState with _$UpdateParkingState {
  const factory UpdateParkingState.initial() = _Initial;
  const factory UpdateParkingState.loading() = _Loading;
  const factory UpdateParkingState.success() = _Success;
  const factory UpdateParkingState.failed() = _Failed;
}
