import 'package:flutter/material.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/presentation/get_history/widgets/history_list_view_widget.dart';

class GenericHistoryListViewWidget extends StatelessWidget {
  final TextEditingController dateController;
  final List<ParkingEntity> parkingHistoryList;

  const GenericHistoryListViewWidget({
    super.key,
    required this.parkingHistoryList,
    required this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    return HistoryListViewWidget(
      parkingHistoryList: parkingHistoryList,
      dateController: dateController,
    );
  }
}
