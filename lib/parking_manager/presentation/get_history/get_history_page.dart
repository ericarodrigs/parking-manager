import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/presentation/get_history/bloc/get_history_bloc.dart';
import 'package:parking_manager/shared/themes/app_colors.dart';
import 'package:parking_manager/shared/themes/app_text_styles.dart';

class GetHistoryPage extends StatelessWidget {
  const GetHistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final historyBloc = BlocProvider.of<GetHistoryBloc>(context);
    TextEditingController dateController = TextEditingController(
        text: DateTime.now().toIso8601String().split('T')[0]);

    late Widget finalView;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: AppTextStyles.bold24black(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () {
                showDataPicker(context, historyBloc, dateController);
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<GetHistoryBloc, GetHistoryState>(
        builder: (context, state) {
          state.when(
            initial: () => finalView = HistoryListView(
              parkingHistoryList: const [],
              dateController: dateController,
            ),
            loading: () => finalView = const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
            loaded: (parking) => finalView = HistoryListView(
              parkingHistoryList: parking,
              dateController: dateController,
            ),
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

  void showDataPicker(BuildContext context, GetHistoryBloc historyBloc,
      TextEditingController dateController) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: 'd MMM, yyyy',
            firstDate: DateTime(2023),
            lastDate: DateTime(2025),
            icon: const Icon(Icons.event),
            dateLabelText: 'Entry date',
            controller: dateController,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Search'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    historyBloc.add(
                      GetAllHistoryEvent(dateController.text),
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class HistoryListView extends StatelessWidget {
  final List<ParkingEntity> parkingHistoryList;
  final TextEditingController dateController;
  const HistoryListView({
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
                  'Balance of: ${getFormattedDate()}',
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
    double totalCost = parkingHistoryList.fold(0.0,
        (sum, parkintEntity) => sum + ((parkintEntity.parkingCost) ?? 0.0));

    return Text(
      'The total value of the day was:\nR\$ ${totalCost.toStringAsFixed(2)}',
      style: AppTextStyles.bold16white(),
      textAlign: TextAlign.center,
    );
  }

  String getFormattedDate() {
    DateTime currentDate = DateTime.parse(dateController.text);

    return '${currentDate.day}/'
        '${currentDate.month}/'
        '${currentDate.year} ';
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
                'Checkin: ${getFormattedDateAndHour(parkingEntity.checkinTime)}',
                style: AppTextStyles.bold16white(),
              ),
              const SizedBox(height: 4),
              Text(
                'Checkout: ${getFormattedDateAndHour(parkingEntity.checkoutTime)}',
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

  getFormattedDateAndHour(String? date) {
    if (date == null || date.isEmpty) return '';
    DateTime currentDate = DateTime.parse(date);

    return '${currentDate.day}/'
        '${currentDate.month}/'
        '${currentDate.year} '
        '${currentDate.hour.toString().padLeft(2, '0')}:'
        '${currentDate.minute.toString().padLeft(2, '0')}';
  }
}
