import 'package:flutter/material.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/shared/themes/app_colors.dart';
import 'package:parking_manager/shared/themes/app_text_styles.dart';
import 'package:parking_manager/shared/utils/extensions/currency_extension.dart';
import 'package:parking_manager/shared/utils/extensions/date_extension.dart';

class ParkingHistoryItemWidget extends StatelessWidget {
  final ParkingEntity parkingEntity;
  const ParkingHistoryItemWidget({
    super.key,
    required this.parkingEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: AppColors.primaryLight,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plate: ${parkingEntity.plate}',
                style: AppTextStyles.bold16white(),
              ),
              const SizedBox(height: 4),
              Text(
                'Vacancy: ${parkingEntity.vacancy + 1}',
                style: AppTextStyles.bold16white(),
              ),
              const SizedBox(height: 4),
              Text(
                'Checkin: ${parkingEntity.checkinTime.formatDateAndHour()}',
                style: AppTextStyles.bold16white(),
              ),
              const SizedBox(height: 4),
              Text(
                'Checkout: ${parkingEntity.checkoutTime.formatDateAndHour()}',
                style: AppTextStyles.bold16white(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  thickness: 2,
                  color: AppColors.primaryLight,
                ),
              ),
              Text(
                'Value paid: ${parkingEntity.parkingCost?.reaisLabel()}',
                style: AppTextStyles.bold16white(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
