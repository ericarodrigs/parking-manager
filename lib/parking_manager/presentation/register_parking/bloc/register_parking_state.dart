part of 'register_parking_bloc.dart';

@freezed
class RegisterParkingState with _$RegisterParkingState {
  const factory RegisterParkingState.initial() = _Initial;
  const factory RegisterParkingState.loading() = _Loading;
  const factory RegisterParkingState.success() = _Success;
  const factory RegisterParkingState.failed() = _Failed;
}
