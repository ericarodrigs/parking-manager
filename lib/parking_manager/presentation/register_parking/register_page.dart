import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/presentation/register_parking/bloc/register_parking_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/update_parking/bloc/update_parking_bloc.dart';
import 'package:parking_manager/shared/app_colors.dart';
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
    TextEditingController checkinTimeController =
        TextEditingController(text: parkingEntity?.checkinTime);
    TextEditingController checkoutTimeController =
        TextEditingController(text: parkingEntity?.checkoutTime);
    ParkingEntity parking;

    return Scaffold(
      appBar: AppBar(
        title: parkingEntity == null
            ? const Text('Register')
            : const Text('Update'),
        automaticallyImplyLeading: true,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<RegisterParkingBloc, RegisterParkingState>(
        listener: (context, state) {
          state.when(
            initial: () => null,
            loading: () => null,
            success: () {
              showSnackBar(context, "Added successfully");
              GoRouter.of(context).pushReplacement(AppRouter.root);
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
                  hintText: 'Plate',
                  controller: plateController,
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Entry date',
                    timeLabelText: 'Hour',
                    controller: checkinTimeController,
                    readOnly: (parkingEntity != null),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Exit date',
                    timeLabelText: 'Hour',
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
                parkingEntity == null
                    ? EPrimaryButton(
                        title: 'Save',
                        onPressed: () {
                          parking = ParkingEntity(
                            plate: plateController.text.trim(),
                            checkinTime: checkinTimeController.text,
                            checkoutTime: checkoutTimeController.text,
                            vacancy: vacancy,
                          );
                          print(parking);
                          context.read<RegisterParkingBloc>().add(
                                RegisterNewParkingEvent(parking),
                              );
                        },
                      )
                    : BlocConsumer<UpdateParkingBloc, UpdateParkingState>(
                        listener: (context, state) {
                        state.when(
                          initial: () => null,
                          loading: () => null,
                          success: () {
                            showSnackBar(context, "Updated successfully");
                            GoRouter.of(context)
                                .pushReplacement(AppRouter.root);
                          },
                          failed: () => null,
                        );
                      }, builder: (context, state) {
                        return EPrimaryButton(
                          title: 'Edit',
                          onPressed: () {
                            parking = ParkingEntity(
                              id: parkingEntity!.id,
                              plate: plateController.text.trim(),
                              checkinTime: checkinTimeController.text,
                              checkoutTime: checkoutTimeController.text,
                              vacancy: vacancy,
                            );
                            print(parking);
                            context.read<UpdateParkingBloc>().add(
                                  UpdateNewParkingEvent(parking),
                                );
                          },
                        );
                      }),
              ],
            ),
          );
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
