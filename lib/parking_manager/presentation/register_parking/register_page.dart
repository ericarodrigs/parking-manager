import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/presentation/register_parking/bloc/register_parking_bloc.dart';
import 'package:parking_manager/shared/routes.dart';
import 'package:parking_manager/shared/widgets/e_primary_button.dart';
import 'package:parking_manager/shared/widgets/e_text_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatelessWidget {
  final ParkingEntity? parkingEntity;
  final int vacancy;
  const RegisterPage({
    super.key,
    required this.vacancy,
    this.parkingEntity,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController plateController =
        TextEditingController(text: parkingEntity?.plate);
    TextEditingController checkinTimeController = TextEditingController(
      text: parkingEntity != null
          ? DateTime.tryParse(parkingEntity!.checkinTime.toString()).toString()
          : null,
    );
    TextEditingController checkoutTimeController = TextEditingController(
      text: parkingEntity?.checkoutTime != null
          ? DateTime.tryParse(parkingEntity!.checkoutTime.toString()).toString()
          : null,
    );
    ParkingEntity parking;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
        automaticallyImplyLeading: true,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<RegisterParkingBloc, RegisterParkingState>(
        listener: (context, state) {
          state.when(
            initial: () => null,
            loading: () => null,
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Added Successfully"),
                ),
              );
              GoRouter.of(context).push(AppRouter.root);
            },
            failed: () => null,
          );
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ETextFormField(
                  hintText: 'Placa',
                  controller: plateController,
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Data de entrada',
                    timeLabelText: 'Hora',
                    controller: checkinTimeController,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Data de saída',
                    timeLabelText: 'Hora',
                    controller: checkoutTimeController,
                  ),
                ),
                const SizedBox(height: 8),
                ETextFormField(
                  hintText: 'Qual a vaga',
                  enabled: false,
                  initialValue: parkingEntity != null
                      ? (parkingEntity!.vacancy + 1).toString()
                      : (vacancy + 1).toString(),
                ),
                const Spacer(),
                EPrimaryButton(
                  title: 'Salvar',
                  onPressed: () {
                    parking = ParkingEntity(
                      plate: plateController.text.trim(),
                      checkinTime:
                          convertToTimestamp(checkinTimeController.text)!,
                      checkoutTime:
                          convertToTimestamp(checkoutTimeController.text),
                      vacancy: vacancy,
                    );
                    print(parking);
                    context.read<RegisterParkingBloc>().add(
                          RegisterNewParkingEvent(parking),
                        );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  int? convertToTimestamp(String date) {
    if (date.isEmpty) return null;

    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(date);

    int timestamp = dateTime.millisecondsSinceEpoch;

    return timestamp;
  }
}
