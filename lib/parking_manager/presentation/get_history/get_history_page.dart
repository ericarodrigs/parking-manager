import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking/bloc/get_parking_bloc.dart';
import 'package:parking_manager/shared/app_colors.dart';

class GetHistoryPage extends StatelessWidget {
  const GetHistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Widget finalView;

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: BlocBuilder<GetParkingBloc, GetParkingState>(
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
            error: () => finalView = const Center(child: Text('error')),
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
          padding: const EdgeInsets.all(24),
          child: Card(
            color: AppColors.greyLight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: showTotalCost(parkingHistoryList),
            ),
          ),
        ),
      ],
    );
  }

  Text showTotalCost(List<ParkingEntity> parkingHistoryList) {
    double totalCost = parkingHistoryList.fold(
        0.0, (sum, row) => sum + ((row.parkingCost) ?? 0.0));

    return Text('O valor total do dia foi: R\$ $totalCost');
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
    return Card(
      color: AppColors.primaryLight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Placa: ${parkingEntity.plate}'),
                Text('Vaga: ${parkingEntity.vacancy + 1}'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Checkin: ${parkingEntity.checkinTime}'),
                Text('Checkout: ${parkingEntity.checkoutTime}'),
                Text('Valor Pago: ${parkingEntity.parkingCost}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
