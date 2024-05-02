import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/get_history/bloc/get_history_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/get_history/widgets/generic_history_list_view_widget.dart';
import 'package:parking_manager/shared/themes/app_text_styles.dart';
import 'package:parking_manager/shared/widgets/error.dart';
import 'package:parking_manager/shared/widgets/loading.dart';

class GetHistoryPage extends StatelessWidget {
  const GetHistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final historyBloc = BlocProvider.of<GetHistoryBloc>(context);
    TextEditingController dateController =
        TextEditingController(text: formatDateToday());

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
              onPressed: () =>
                  showDataPicker(context, historyBloc, dateController),
            ),
          ),
        ],
      ),
      body: BlocBuilder<GetHistoryBloc, GetHistoryState>(
        builder: (context, state) {
          state.when(
            initial: () => finalView = GenericHistoryListViewWidget(
                parkingHistoryList: const [], dateController: dateController),
            loading: () => finalView = loadingState,
            loaded: (parking) => finalView = GenericHistoryListViewWidget(
                parkingHistoryList: parking, dateController: dateController),
            error: () => finalView = errorState,
          );
          return finalView;
        },
      ),
    );
  }

  String formatDateToday() => DateTime.now().toIso8601String().split('T')[0];

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
