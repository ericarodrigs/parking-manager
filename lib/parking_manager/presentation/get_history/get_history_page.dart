import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/presentation/get_history/bloc/get_history_bloc.dart';
import 'package:parking_manager/shared/app_colors.dart';
import 'package:parking_manager/shared/app_text_styles.dart';

class GetHistoryPage extends StatelessWidget {
  const GetHistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Widget finalView;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: AppTextStyles.bold24black(),
        ),
      ),
      body: BlocBuilder<GetHistoryBloc, GetHistoryState>(
        builder: (context, state) {
          state.when(
            initial: () =>
                finalView = const HistoryListView(parkingHistoryList: []),
            loading: () => finalView = const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
            loaded: (parking) =>
                finalView = HistoryListView(parkingHistoryList: parking),
            error: () => finalView = Center(
                child: Text(
              'error',
              style: AppTextStyles.bold24black(),
            )),
          );
          return finalView;
        },
      ),
    );
  }
}

class HistoryListView extends StatelessWidget {
  final List<ParkingEntity> parkingHistoryList;
  const HistoryListView({super.key, required this.parkingHistoryList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: parkingHistoryList.length,
            itemBuilder: (context, index) =>
                ParkingHistoryItem(parkingEntity: parkingHistoryList[index]),
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
    double totalCost = parkingHistoryList.fold(
        0.0, (sum, row) => sum + ((row.parkingCost) ?? 0.0));

    return Text(
      'The total value of the day was:\nR\$ ${totalCost.toStringAsFixed(2)}',
      style: AppTextStyles.bold16white(),
      textAlign: TextAlign.center,
    );
  }
}

class ParkingHistoryItem extends StatelessWidget {
  final ParkingEntity parkingEntity;
  const ParkingHistoryItem({
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
                'Checkin: ${parkingEntity.checkinTime}',
                style: AppTextStyles.bold16white(),
              ),
              const SizedBox(height: 4),
              Text(
                'Checkout: ${parkingEntity.checkoutTime}',
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
                'Value paid: R\$ ${parkingEntity.parkingCost?.toStringAsFixed(2)}',
                style: AppTextStyles.bold16white(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
