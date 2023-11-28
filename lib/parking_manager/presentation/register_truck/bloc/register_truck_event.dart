part of 'register_truck_bloc.dart';

@freezed
class RegisterTruckEvent with _$RegisterTruckEvent {
  const factory RegisterTruckEvent.registerTruck(TruckEntity truckEntity) =
      RegisterNewTruckEvent;
}
