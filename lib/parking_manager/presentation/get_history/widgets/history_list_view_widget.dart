import 'package:flutter/material.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/presentation/get_history/widgets/parking_history_item_widget.dart';
import 'package:parking_manager/shared/themes/app_colors.dart';
import 'package:parking_manager/shared/themes/app_text_styles.dart';
import 'package:parking_manager/shared/utils/extensions/currency_extension.dart';
import 'package:parking_manager/shared/utils/extensions/date_extension.dart';

class HistoryListViewWidget extends StatelessWidget {
  final List<ParkingEntity> parkingHistoryList;
  final TextEditingController dateController;

  const HistoryListViewWidget({
    super.key,
    required this.parkingHistoryList,
    required this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: AppColors.greyLight,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  'Balance of: ${dateController.text.formatDate()}',
                  style: AppTextStyles.bold16white(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: parkingHistoryList.length,
            itemBuilder: (context, index) => ParkingHistoryItemWidget(
                parkingEntity: parkingHistoryList[index]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: AppColors.greyLight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: showTotalCost(parkingHistoryList),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Text showTotalCost(List<ParkingEntity> parkingHistoryList) {
    double totalCost = parkingHistoryList.fold(0.0,
        (sum, parkintEntity) => sum + ((parkintEntity.parkingCost) ?? 0.0));

    return Text(
      'The total value of the day was:\n${totalCost.reaisLabel()}',
      style: AppTextStyles.bold16white(),
      textAlign: TextAlign.center,
    );
  }
}
