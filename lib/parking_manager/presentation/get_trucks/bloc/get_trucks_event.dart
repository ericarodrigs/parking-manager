part of 'get_trucks_bloc.dart';

@freezed
class GetTrucksEvent with _$GetTrucksEvent {
  const factory GetTrucksEvent.getTrucks() = GetAllTrucksEvent;
}
