part of 'register_parking_bloc.dart';

@freezed
class RegisterParkingEvent with _$RegisterParkingEvent {
  const factory RegisterParkingEvent.registerParking(
      ParkingEntity parkingEntity) = RegisterNewParkingEvent;
}
