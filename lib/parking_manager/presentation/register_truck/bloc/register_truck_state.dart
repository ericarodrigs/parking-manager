part of 'register_truck_bloc.dart';

@freezed
class RegisterTruckState with _$RegisterTruckState {
  const factory RegisterTruckState.initial() = _Initial;
  const factory RegisterTruckState.loading() = _Loading;
  const factory RegisterTruckState.success() = _Success;
  const factory RegisterTruckState.failed() = _Failed;
}
