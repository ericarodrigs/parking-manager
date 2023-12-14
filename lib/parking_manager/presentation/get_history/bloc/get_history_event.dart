part of 'get_history_bloc.dart';

@freezed
class GetHistoryEvent with _$GetHistoryEvent {
  const factory GetHistoryEvent.getHistory(String dateSearch) =
      GetAllHistoryEvent;
}
