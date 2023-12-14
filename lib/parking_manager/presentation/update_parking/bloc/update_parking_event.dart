part of 'update_parking_bloc.dart';

@freezed
class UpdateParkingEvent with _$UpdateParkingEvent {
  const factory UpdateParkingEvent.updateParking(ParkingEntity parkingEntity) =
      UpdateNewParkingEvent;
}
