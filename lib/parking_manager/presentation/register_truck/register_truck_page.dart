import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';
import 'package:parking_manager/parking_manager/presentation/register_truck/bloc/register_truck_bloc.dart';
import 'package:parking_manager/shared/routes.dart';
import 'package:parking_manager/shared/widgets/e_primary_button.dart';
import 'package:parking_manager/shared/widgets/e_text_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController plateController = TextEditingController();
    TextEditingController checkinTimeController = TextEditingController();
    TextEditingController checkoutTimeController = TextEditingController();
    TextEditingController vacancyController = TextEditingController();
    TextEditingController driverController = TextEditingController();
    TextEditingController checkoutValueController = TextEditingController();
    TruckEntity truck;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
        automaticallyImplyLeading: true,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<RegisterTruckBloc, RegisterTruckState>(
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
              GoRouter.of(context).go(AppRouter.root);
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
                  controller: vacancyController,
                ),
                const SizedBox(height: 8),
                ETextFormField(
                  hintText: 'Nome do motorista',
                  controller: driverController,
                ),
                const SizedBox(height: 8),
                ETextFormField(
                  hintText: 'Valor pago',
                  controller: checkoutValueController,
                ),
                const Spacer(),
                EPrimaryButton(
                  title: 'Salvar',
                  onPressed: () {
                    truck = TruckEntity(
                      plate: plateController.text,
                      // checkinTime: DateTime.tryParse(checkinTimeController.text)
                      //         ?.toLocal() ??
                      //     DateTime.now(),
                      // checkoutTime:
                      //     DateTime.tryParse(checkoutTimeController.text)
                      //             ?.toLocal() ??
                      //         DateTime.now(),
                      vacancy: vacancyController.text,
                      driver: driverController.text,
                      // checkoutValue:
                      //     double.tryParse(checkoutValueController.text),
                    );
                    context.read<RegisterTruckBloc>().add(
                          RegisterNewTruckEvent(truck),
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
}
